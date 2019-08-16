import Vapor

public class Constants {
    
    private init() { }
    
    public static var cloudinaryName: String {
        return Environment.get("CLOUDINARY_ACCOUNT_NAME") ?? "chameli"
    }
    
    public static var databaseUrl: String {
        return Environment.get("DATABASE_URL") ?? "postgres://qrbwaaavwaawca:4da672db9f9e8cfb9ef6a8a659da33754b2ec771e4ba9d984baf141e9ea48331@ec2-54-217-234-157.eu-west-1.compute.amazonaws.com:5432/d7vjbrh928fmdo"
    }
    
}
