import Vapor

public struct ApiResponse<T>: Content where T: Content {
    
    public let success: Bool
    public let error: ApiError?
    public let data: T?
    
    public static func success(withData data: T) -> ApiResponse<T> {
        return .init(success: true, error: nil, data: data)
    }
    
    public static func fail(withError error: ApiError) -> ApiResponse<T> {
        return .init(success: false, error: error, data: nil)
    }
    
}
