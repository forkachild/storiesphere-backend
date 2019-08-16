import Foundation

extension Date {
    
    public func adding(days d: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: d, to: self)!
    }
    
}
