import Vapor
import FluentPostgreSQL

public final class TokenUser: PostgreSQLModel {
    
    public static let createdAtKey: TimestampKey? = \.createdAt
    public static let updatedAtKey: TimestampKey? = \.updatedAt
    public static let deletedAtKey: TimestampKey? = \.deletedAt
    
    public var id: Int?
    public var token: String
    public var userID: Int
    public var validTill: Date
    public var createdAt: Date?
    public var updatedAt: Date?
    public var deletedAt: Date?
    
    public var parent: Parent<TokenUser, User> {
        return parent(\.userID)
    }
    
    public init(id: Int? = nil, token: String, userID: Int, validTill: Date) {
        self.id = id
        self.token = token
        self.userID = userID
        self.validTill = validTill
    }
    
}

extension TokenUser: Migration { }

extension TokenUser: Parameter { }
