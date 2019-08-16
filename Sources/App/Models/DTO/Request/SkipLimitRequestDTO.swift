import Vapor

public struct SkipLimitRequestDTO {
    
    public let skip: Int = 0
    public let limit: Int = 50
    
}

extension SkipLimitRequestDTO: Content {
    
    public enum CodingKeys: String, CodingKey {
        
        case skip = "skip"
        case limit = "limit"
        
    }
    
}

extension SkipLimitRequestDTO: Validatable {
    
    public static func validations() throws -> Validations<SkipLimitRequestDTO> {
        var validations = Validations(SkipLimitRequestDTO.self)
        
        validations.add(\.skip, at: ["Skip"], .range(0...))
        validations.add(\.limit, at: ["Limit"], .range(1...50))
        
        return validations
    }
    
}
