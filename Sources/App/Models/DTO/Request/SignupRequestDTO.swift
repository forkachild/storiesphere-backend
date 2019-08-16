import Vapor

public struct SignupRequestDTO {
    
    public let name: String
    public let email: String
    public let password: String
    
}

extension SignupRequestDTO: Content {
    
    public enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case email = "email"
        case password = "password"
        
    }
    
}

extension SignupRequestDTO: Validatable {
    
    public static func validations() throws -> Validations<SignupRequestDTO> {
        var validations = Validations(SignupRequestDTO.self)
        
        validations.add(\.email, at: ["Email"], .email)
        validations.add(\.password, at: ["Password"], .count(6...14))
        
        return validations
    }
    
}
