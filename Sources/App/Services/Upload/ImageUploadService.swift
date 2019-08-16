import Vapor

public protocol ImageUploadService {
    
    func upload(file: File, withPublicIdentifier id: String, on req: Request) throws -> Future<ImageUploadResponseDTO>
    
}
