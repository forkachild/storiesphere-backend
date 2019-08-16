import Vapor

public struct PostDTO {
    
    public let id: Int?
    public let title: String?
    public let story: String
    public let imageUrl: String?
    public let createdAt: Date?
    public let updatedAt: Date?
    
}

extension PostDTO: Content {
    
    public enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case title = "title"
        case story = "story"
        case imageUrl = "image_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        
    }
    
}

extension PostDTO {
    
    init(fromPost post: Post) {
        self.id = post.id
        self.title = post.title
        self.story = post.story
        self.createdAt = post.createdAt
        self.updatedAt = post.updatedAt
        
        if let id = self.id {
            self.imageUrl = "https://res.cloudinary.com/\(Constants.cloudinaryName)/storiesphere/\(id)"
        } else {
            self.imageUrl = nil
        }
    }

    
}
