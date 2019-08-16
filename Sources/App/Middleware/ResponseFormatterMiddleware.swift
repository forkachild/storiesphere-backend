import Vapor

public class ResponseFormatterMiddleware: Middleware {
    
    public required init() { }
    
    public func respond(to request: Request, chainingTo next: Responder) throws -> EventLoopFuture<Response> {
        let promise = request.eventLoop.newPromise(Response.self)
        
        DispatchQueue.global(qos: .background).async {
            
            do {
                
                let response = try next.respond(to: request).wait()
                
                promise.succeed(result: response)
                
            } catch {
                
                switch error {
                    
                case let apiError as ApiError: do {
                    let errorResponse = ApiEmptyResponse.fail(withError: apiError)
                    
                    let response: Response
                    
                    do {
                        response = try errorResponse.encode(for: request).wait()
                    } catch {
                        response = request.response("{\"success\":\(errorResponse.success),\"error\":{\"code\":\(errorResponse.error!.code),\"reason\":\"\(errorResponse.error!.message)\"}}", as: .json)
                    }
                    
                    promise.succeed(result: response)
                    }
                    
                default: do {
                    let apiError = ApiErrors.unknown.error()
                    let errorResponse = ApiEmptyResponse.fail(withError: apiError)
                    
                    let response: Response
                    
                    do {
                        response = try errorResponse.encode(for: request).wait()
                    } catch {
                        response = request.response("{\"success\":\(errorResponse.success),\"error\":{\"code\":\(errorResponse.error!.code),\"reason\":\"\(errorResponse.error!.message)\"}}", as: .json)
                    }
                    
                    promise.succeed(result: response)
                    }
                    
                }
            
            }
            
        }
        
        return promise.futureResult
    }
    
}

extension ResponseFormatterMiddleware: ServiceType {
    
    public static func makeService(for container: Container) throws -> Self {
        return .init()
    }
    
}
