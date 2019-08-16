import Vapor

public struct ApiEmptyResponse: Content {
    
    public let success: Bool
    public let error: ApiError?
    
    public static func success() -> ApiEmptyResponse {
        return .init(success: true, error: nil)
    }
    
    public static func fail(withError error: ApiError) -> ApiEmptyResponse {
        return .init(success: false, error: error)
    }
    
}
