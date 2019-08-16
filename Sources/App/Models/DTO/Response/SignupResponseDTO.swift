import Vapor

public struct SignupResponseDTO {
    
    public let user: UserDTO
    public let token: String
    
}

extension SignupResponseDTO: Content {
    
    public enum CodingKeys: String, CodingKey {
        
        case user = "user"
        case token = "token"
        
    }
    
}
