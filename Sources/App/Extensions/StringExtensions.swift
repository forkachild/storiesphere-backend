extension String {
    
    public static func random(ofLength length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    public static var serverToken: String {
        return self.random(ofLength: 32)
    }
    
}
