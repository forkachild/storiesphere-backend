import Vapor
import FluentPostgreSQL

public class AuthUserMiddleware: Middleware {
    
    public required init() { }
    
    public func respond(to request: Request, chainingTo next: Responder) throws -> EventLoopFuture<Response> {
        
        guard let _ = request.token else {
            throw ApiErrors.tokenNotFound.error()
        }
        
        return try next.respond(to: request)
    }
    
}

extension AuthUserMiddleware: ServiceType {
    
    public static func makeService(for container: Container) throws -> Self {
        return .init()
    }
    
}
