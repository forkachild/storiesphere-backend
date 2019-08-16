import Vapor

public final class DefaultImageUploadService: ImageUploadService {
    
    public func upload(file: File, withPublicIdentifier id: String, on req: Request) throws -> EventLoopFuture<ImageUploadResponseDTO> {
        let promise = req.eventLoop.newPromise(ImageUploadResponseDTO.self)
        
        DispatchQueue.global(qos: .background).async {
            
            do {
                
                let response = try req
                    .client()
                    .post("https://api.cloudinary.com/v1_1/\(Constants.cloudinaryName)/image/upload", headers: .init()) { uploadReq in
                        
                        let request = ImageUploadRequestDTO(uploadPreset: "imagery", file: file, publicID: id)
                        
                        try uploadReq.content.encode(request, as: .formData)
                    }
                    .wait()
                
                let parsedUpload = try response.content.decode(ImageUploadResponseDTO.self).wait()
                promise.succeed(result: parsedUpload)
                
            } catch {
                promise.fail(error: error)
            }
            
        }
        
        return promise.futureResult
    }
    
}

extension DefaultImageUploadService: Service { }
