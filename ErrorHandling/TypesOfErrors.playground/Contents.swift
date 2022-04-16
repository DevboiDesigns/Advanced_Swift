import UIKit

enum BankAccountError: Error {
    case insuficientFunds
    case accountClosed
}

class BankAccount {
    
    var balance: Double
    
    init(balance: Double) {
        self.balance = balance
    }
    
    func withdraw(amount: Double) throws {
        if balance < amount {
            // throw an error
            throw BankAccountError.insuficientFunds
        }
        
        balance -= amount
    }
}


let account = BankAccount(balance: 100)

do {
    try account.withdraw(amount: 300)
} catch {
    print(error)
}



