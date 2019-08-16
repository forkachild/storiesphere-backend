import FluentPostgreSQL
import Vapor

public final class User: PostgreSQLModel {
    
    public static let createdAtKey: TimestampKey? = \.createdAt
    public static let updatedAtKey: TimestampKey? = \.updatedAt
    public static let deletedAtKey: TimestampKey? = \.deletedAt
    
    public var id: Int?
    public var name: String
    public var email: String
    public var password: String
    public var createdAt: Date?
    public var updatedAt: Date?
    public var deletedAt: Date?
    public var tokenUsers: Children<User, TokenUser> {
        return children(\.userID)
    }
    
    public init(id: Int? = nil, name: String, email: String, password: String) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
    }
    
}

extension User: Migration { }

extension User: Parameter { }
