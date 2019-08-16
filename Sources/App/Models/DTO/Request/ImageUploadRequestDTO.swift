import Vapor

public struct ImageUploadRequestDTO {
    
    public let uploadPreset: String
    public let file: File
    public let publicID: String
    
}

extension ImageUploadRequestDTO: Content {
    
    public enum CodingKeys: String, CodingKey {
        
        case uploadPreset = "upload_preset"
        case file = "file"
        case publicID = "public_id"
        
    }
    
}
