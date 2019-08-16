import Vapor

class ImageSizeValidator: ValidatorType {
    
    typealias ValidationData = File?
    
    let maxSize: Int
    
    init(_ maxSize: Int) {
        self.maxSize = maxSize
    }
    
    var validatorReadable: String {
        return "a valid file"
    }
    
    func validate(_ data: File?) throws {
        if let file = data,
            let mediaType = file.contentType {
            
            if mediaType != .png && mediaType != .jpeg {
                throw ApiErrors.imageFormatNotSupported.error()
            }
            
            if file.data.count > maxSize {
                throw ApiErrors.imageSizeTooLarge.error()
            }
            
        }
    }
    
}

extension Validator where T == File? {
    
    public static func image(withMaxSize maxSize: Int) -> Validator<T> {
        return ImageSizeValidator(maxSize).validator()
    }
    
}
