import Vapor
import FluentPostgreSQL

public final class DefaultUsersController: UsersController {
    
    public func signup(_ req: Request) throws -> EventLoopFuture<ApiResponse<SignupResponseDTO>> {
        let promise = req.eventLoop.newPromise(ApiResponse<SignupResponseDTO>.self)
        
        DispatchQueue.global(qos: .background).async {
            
            do {
                
                let requestContent = try req.content.decode(SignupRequestDTO.self).wait()
                try requestContent.validate()
                
                let existingUserByEmail = try User.query(on: req)
                    .filter(\.email == requestContent.email)
                    .first()
                    .wait()
                
                if existingUserByEmail != nil {
                    throw ApiErrors.alreadyExists.error(withCustomReason: "User already exists with email \(requestContent.email)")
                }
                
                let newUser = try User(name: requestContent.name, email: requestContent.email, password: requestContent.password)
                    .create(on: req)
                    .wait()
                
                if let id = newUser.id {
                    let tokenUser = try TokenUser(token: String.serverToken, userID: id, validTill: Date().adding(days: 30))
                        .create(on: req)
                        .wait()
                    
                    promise.succeed(result: .success(withData: .init(user: .init(from: newUser), token: tokenUser.token)))
                    
                } else {
                    throw ApiErrors.unknown.error()
                }
                
            } catch {
                promise.fail(error: error)
            }
            
        }
        
        return promise.futureResult
    }
    
    public func signin(_ req: Request) throws -> EventLoopFuture<ApiResponse<SigninResponseDTO>> {
        let promise = req.eventLoop.newPromise(ApiResponse<SigninResponseDTO>.self)
        
        DispatchQueue.global(qos: .background).async {
            
            do {
                
                let requestContent = try req.content.decode(SigninRequestDTO.self).wait()
                try requestContent.validate()
                
                let existingUser = try User.query(on: req)
                    .filter(\.email == requestContent.email)
                    .first()
                    .unwrap(or: ApiErrors.doesntExist.error())
                    .wait()
                
                if existingUser.password != requestContent.password {
                    throw ApiErrors.passwordMismatch.error()
                }
                
                if let id = existingUser.id {
                    let existingTokenUser = try TokenUser.query(on: req)
                        .filter(\.userID == id)
                        .first()
                        .wait()
                    
                    if existingTokenUser == nil {
                        
                        let newTokenUser = try TokenUser(token: String.serverToken, userID: id, validTill: Date().adding(days: 30))
                            .create(on: req)
                            .wait()
                        
                        promise.succeed(result: .success(withData: .init(user: .init(from: existingUser), token: newTokenUser.token)))
                        
                    } else {
                        
                        existingTokenUser?.token = String.serverToken
                        existingTokenUser?.validTill = Date().adding(days: 30)
                        
                        let updatedTokenUser = try TokenUser.query(on: req)
                            .update(existingTokenUser!)
                            .wait()
                        
                        promise.succeed(result: .success(withData: .init(user: .init(from: existingUser), token: updatedTokenUser.token)))
                        
                    }
                    
                } else {
                    throw ApiErrors.unknown.error()
                }
                
            } catch {
                promise.fail(error: error)
            }
            
        }
        
        return promise.futureResult
    }
    
    public func getProfile(_ req: Request) throws -> EventLoopFuture<ApiResponse<UserDTO>> {
        return try req.requireAuthenticatedUser()
            .map { user in
                
                return .success(withData: .init(from: user))
        }
    }
    
}

extension DefaultUsersController {
    
    public func boot(router: Router) throws {
        let grouped = router.grouped("users")
        
        grouped.post("signup", use: self.signup)
        grouped.post("signin", use: self.signin)
        grouped.grouped(AuthUserMiddleware.self).get(use: self.getProfile)
    }
    
}
