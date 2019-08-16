import Foundation

extension Date {
    
    public init(addingDays days: Int) {
        self = Calendar.current.date(byAdding: .day, value: days, to: Date())!
    }
    
}
