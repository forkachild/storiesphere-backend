import Vapor

public protocol UsersController: RouteCollection {
    
    func signup(_ req: Request) throws -> EventLoopFuture<ApiResponse<SignupResponseDTO>>
    
    func signin(_ req: Request) throws -> EventLoopFuture<ApiResponse<SigninResponseDTO>>
    
    func getProfile(_ req: Request) throws -> EventLoopFuture<ApiResponse<UserDTO>>
    
}
