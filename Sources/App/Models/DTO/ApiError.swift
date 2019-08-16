import Vapor

public struct ApiError: Debuggable, Content {
    
    public var identifier: String {
        return "Identifier"
    }
    
    public var reason: String {
        return message
    }
    
    public let code: Int
    public let message: String
    
}

public enum ApiErrors: Int {
    
    case unknown = 1
    case sessionNotFound
    case tokenNotFound
    case invalidToken
    case doesntExist
    case alreadyExists
    case passwordMismatch
    case imageSizeTooLarge
    case imageFormatNotSupported
    
    public func error(withCustomReason reason: String? = nil) -> ApiError {
        
        switch self {
            
        case .unknown:
            return .init(code: self.rawValue, message: reason ?? "Unknown")
            
        case .sessionNotFound:
            return .init(code: self.rawValue, message: reason ?? "Session not found")
            
        case .tokenNotFound:
            return .init(code: self.rawValue, message: reason ?? "Token not found")
            
        case .invalidToken:
            return .init(code: self.rawValue, message: reason ?? "Invalid token")
            
        case .doesntExist:
            return .init(code: self.rawValue, message: reason ?? "Doesn't exist")
            
        case .alreadyExists:
            return .init(code: self.rawValue, message: reason ?? "Already exists")
            
        case .passwordMismatch:
            return .init(code: self.rawValue, message: reason ?? "Password mismatch")
            
        case .imageSizeTooLarge:
            return .init(code: self.rawValue, message: reason ?? "Image size too large")
            
        case .imageFormatNotSupported:
            return .init(code: self.rawValue, message: reason ?? "Image format not supported")
            
        }
        
    }
    
}
