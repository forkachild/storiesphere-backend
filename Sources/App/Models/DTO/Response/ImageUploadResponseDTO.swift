import Foundation
import Vapor

public struct ImageUploadResponseDTO {
    
    public let publicID: String
    public let version: Int
    public let signature: String
    public let width: Int
    public let height: Int
    public let format: String
    public let resourceType: String
    public let createdAt: Date
    public let tags: [String]
    public let bytes: Int
    public let type: String
    public let etag: String
    public let placeholder: Bool
    public let url: String
    public let secureUrl: String
    public let accessMode: String
    public let existing: Bool
    public let originalFilename: String
    public let originalExtension: String?
    
}

extension ImageUploadResponseDTO: Content {
    
    public enum CodingKeys: String, CodingKey {
        
        case publicID = "public_id"
        case version = "version"
        case signature = "signature"
        case width = "width"
        case height = "height"
        case format = "format"
        case resourceType = "resource_type"
        case createdAt = "created_at"
        case tags = "tags"
        case bytes = "bytes"
        case type = "type"
        case etag = "etag"
        case placeholder = "placeholder"
        case url = "url"
        case secureUrl = "secure_url"
        case accessMode = "access_mode"
        case existing = "existing"
        case originalFilename = "original_filename"
        case originalExtension = "original_extension"
        
    }
    
}
