import Vapor

public struct CreatePostRequestDTO {
    
    public let title: String?
    public let story: String
    public let image: File?
    
}

extension CreatePostRequestDTO: Content {
    
    public enum CodingKeys: String, CodingKey {
        
        case title = "title"
        case story = "story"
        case image = "image"
        
    }
    
}

extension CreatePostRequestDTO: Validatable {
    
    public static func validations() throws -> Validations<CreatePostRequestDTO> {
        var validations = Validations(CreatePostRequestDTO.self)
        
        validations.add(\.image, at: ["Image"], .image(withMaxSize: 10 * 1024 * 1024))
        
        return validations
    }
    
}
