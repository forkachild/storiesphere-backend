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
                
                let response: Response
                let errorResponse: ApiEmptyResponse
                
                switch error {
                    
                case let apiError as ApiError:
                    errorResponse = ApiEmptyResponse.fail(withError: apiError)
                    
                default:
                    errorResponse = ApiEmptyResponse.fail(withError: ApiErrors.unknown.error())
                    
                }
                
                do {
                    response = try errorResponse.encode(for: request).wait()
                } catch {
                    let error = errorResponse.error!
                    response = request.response(
                        self.createRawJSONString(withSuccess: false,
                                                 errorCode: error.code,
                                                 errorMessage: error.message),
                        as: .json)
                }
                
                promise.succeed(result: response)
                
            }
            
        }
        
        return promise.futureResult
    }
    
    private func createRawJSONString(withSuccess success: Bool,
                                     errorCode code: Int,
                                     errorMessage message: String) -> String {
        return "{\"success\":\(success),\"error\":{\"code\":\(code),\"reason\":\"\(message)\"}}"
    }
    
}

extension ResponseFormatterMiddleware: ServiceType {
    
    public static func makeService(for container: Container) throws -> Self {
        return .init()
    }
    
}
