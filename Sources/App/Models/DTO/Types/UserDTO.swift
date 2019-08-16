import Vapor

public struct UserDTO {
    
    public let id: Int?
    public let name: String
    public let email: String
    public let createdAt: Date?
    public let updatedAt: Date?
    
}

extension UserDTO: Content {
    
    public enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case email = "email"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        
    }
    
}

extension UserDTO {
    
    public init(from user: User) {
        self.id = user.id
        self.name = user.name
        self.email = user.email
        self.createdAt = user.createdAt
        self.updatedAt = user.updatedAt
    }
    
}
