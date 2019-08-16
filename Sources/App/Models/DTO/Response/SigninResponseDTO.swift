import Vapor

public struct SigninResponseDTO {
    
    public let user: UserDTO
    public let token: String
    
}

extension SigninResponseDTO: Content {
    
    public enum CodingKeys: String, CodingKey {
        
        case user = "user"
        case token = "token"
        
    }
    
}
