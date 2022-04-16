import UIKit

struct Student {
    let firstname: String?
    let lastname: String?
    
    var displayName: String? {
        switch (firstname, lastname) {
            case let (first?, last?): return "\(first) \(last)"
            case let (first?, nil): return first
            case let (nil, last?): return last
            default: return nil
        }
    }
}

var student = Student(firstname: nil, lastname: nil)

func createGreetingMessage(student: Student) -> String {
    let message = """
        Dear \(student.displayName ?? "Student"), Welcome to Swift University
        """
    return message
}

let message = createGreetingMessage(student: student)
print(message)


