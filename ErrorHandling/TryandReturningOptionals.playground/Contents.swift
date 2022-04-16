import UIKit

enum ValidationError: Error {
    case noEmptyValueAllowed
    case invalidEmail
}

struct Email {
    var text: String
    
    init(_ text: String) throws {
        guard !text.isEmpty else { throw ValidationError.noEmptyValueAllowed }
        
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        
        let isValid = emailPredicate.evaluate(with: text)
        
        if isValid {
            self.text = text
        } else {
            throw ValidationError.invalidEmail
        }
    }
}



/*
do {
    let email = try Email("johndoe@gmail.com")
    print(email)
} catch {
    print(error)
}
 */

// do not need error message - will just return nil and not stop the app
let email = try! Email("sdfj")
print(email)
