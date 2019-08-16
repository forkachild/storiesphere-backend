import Vapor
import FluentPostgreSQL

extension Request {
    
    public var token: String? {
        return self.http.headers[.authorization].first
    }
    
    public func requireAuthenticatedUser() throws -> Future<User> {
        if let token = self.token {
            
            return User.query(on: self)
                .join(\TokenUser.userID, to: \User.id)
                .filter(\TokenUser.token == token)
                .first()
                .unwrap(or: ApiErrors.invalidToken.error())
            
        } else {
            throw ApiErrors.tokenNotFound.error()
        }
    }
    
}

