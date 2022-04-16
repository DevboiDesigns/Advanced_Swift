import UIKit

struct Account {
    var balance: Double
}

extension Account {
    
    mutating func deposit(_ amount: Double) {
        balance += amount
    }
    
    mutating func withdraw(_ amount: Double) {
        // ---  (-)
        balance += amount
    }
    
    func calculateInterestEarned() -> Double {
        return (balance * (0.1/100))
    }
}
