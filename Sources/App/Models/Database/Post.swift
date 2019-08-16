import FluentPostgreSQL
import Vapor

public final class Post: PostgreSQLModel {
    
    public static let createdAtKey: TimestampKey? = \.createdAt
    public static let updatedAtKey: TimestampKey? = \.updatedAt
    public static let deletedAtKey: TimestampKey? = \.deletedAt
    
    public var id: Int?
    public var title: String?
    public var story: String
    public var createdAt: Date?
    public var updatedAt: Date?
    public var deletedAt: Date?
    
    public init(id: Int? = nil,
                title: String? = nil,
                story: String) {
        self.id = id
        self.title = title
        self.story = story
    }
    
}

extension Post: Migration { }

extension Post: Parameter { }
