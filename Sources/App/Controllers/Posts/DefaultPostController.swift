import Vapor

public final class DefaultPostController: PostsController {
    
    public func create(_ req: Request) throws -> EventLoopFuture<ApiResponse<PostDTO>> {
        return req.transaction(on: .psql) { conn in
            
            let promise = req.eventLoop.newPromise(ApiResponse<PostDTO>.self)
            
            DispatchQueue.global(qos: .background).async {
                
                do {
                    
                    let requestContent = try req.content.decode(CreatePostRequestDTO.self).wait()
                    try requestContent.validate()
                    
                    let newPost = try Post(id: nil, title: requestContent.title, story: requestContent.story).create(on: conn).wait()
                    
                    if let file = requestContent.image {
                        let imageUploader = try req.make(ImageUploadService.self)
                        let _ = try imageUploader.upload(file: file, withPublicIdentifier: String(newPost.id ?? 0), on: req).wait()
                    }
                    
                    promise.succeed(result: .success(withData: .init(fromPost: newPost)))
                    
                } catch {
                    promise.fail(error: error)
                }
                
            }
            
            return promise.futureResult
            
        }
    }
    
    public func listAll(_ req: Request) throws -> EventLoopFuture<ApiResponse<[PostDTO]>> {
        let promise = req.eventLoop.newPromise(ApiResponse<[PostDTO]>.self)
        
        DispatchQueue.global(qos: .background).async {
            
            do {
                
                let skipLimit = try req.query.decode(SkipLimitRequestDTO.self)
                try skipLimit.validate()
                
                let posts = try Post.query(on: req)
                    .range(lower: skipLimit.skip, upper: (skipLimit.skip + skipLimit.limit))
                    .sort(\.createdAt, .descending)
                    .all()
                    .wait()
                
                promise.succeed(result: .success(withData: posts.map { .init(fromPost: $0) }))
                
            } catch {
                promise.fail(error: error)
            }
            
        }
        
        return promise.futureResult
    }
    
}

extension DefaultPostController {
    
    public func boot(router: Router) throws {
        let grouped = router.grouped("posts")
        
        grouped.grouped(AuthUserMiddleware.self).post(use: self.create)
        grouped.get(use: self.listAll)
    }
    
}
