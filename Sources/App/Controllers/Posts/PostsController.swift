import Vapor

public protocol PostsController: RouteCollection {
    
    func create(_ req: Request) throws -> EventLoopFuture<ApiResponse<PostDTO>>
    
    func listAll(_ req: Request) throws -> EventLoopFuture<ApiResponse<[PostDTO]>>
    
}
