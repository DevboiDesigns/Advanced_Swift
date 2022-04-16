import UIKit



protocol Account {
    var balance: Double { get set }
    mutating func deposit(_ amount: Double)
    mutating func withdraw(_ amount: Double)
    func calculateInterestEarned() -> Double
    func transfer(from: Account, to: Account, amount: Double)
}

extension Account {
    mutating func deposit(_ amount: Double) { balance += amount }
    mutating func withdraw(_ amount: Double) { balance -= amount }
    func calculateInterestEarned() -> Double { return (balance * (0.1/100)) }
}

struct VerificationRequest {
    let accounts: [Account]
}

struct VerificationResponse {
    let verified: Bool
}

// 2nd Protocol
protocol Verification {
    func performVerification(_ request: VerificationRequest, complete: (VerificationResponse) -> Void)
}

extension Verification {
    func performVerification(_ request: VerificationRequest, complete: (VerificationResponse) -> Void) {
        // perform verificaton logic
    }
}


struct CheckingAccount: Account, Verification {
    var balance: Double
    
    func transfer(from: Account, to: Account, amount: Double) {
        self.performVerification(VerificationRequest(accounts: [from, to])) { (response) in
            if response.verified {
                // transfer funds
            }
        }
    }
}


struct MoneyMarketAccount: Account, Verification {
    var balance: Double
    
    func transfer(from: Account, to: Account, amount: Double) {
        //
    }
}
