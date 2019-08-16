import Vapor

public struct SigninRequestDTO {
    
    public let email: String
    public let password: String
    
}

extension SigninRequestDTO: Content {
    
    public enum CodingKeys: String, CodingKey {
        
        case email = "email"
        case password = "password"
        
    }
    
}

extension SigninRequestDTO: Validatable {
    
    public static func validations() throws -> Validations<SigninRequestDTO> {
        var validations = Validations(SigninRequestDTO.self)
        
        validations.add(\.email, at: ["Email"], .email)
        validations.add(\.password, at: ["Password"], .count(6...14))
        
        return validations
    }
    
}
