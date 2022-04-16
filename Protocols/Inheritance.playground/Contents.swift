import UIKit

struct Course {
    let courseNumber: String
    let name: String
    let creditHours: Int
}

protocol Student {
    var courses: [Course] { get set }
    mutating func enroll(_ course: Course)
}

extension Student {
    mutating func enroll(_ course: Course) {
        courses.append(course)
    }
}

// All inheriting types must conform to Student
protocol VerifyStudent where Self: Student {
    func verify() -> Bool
}

extension VerifyStudent {
    func enroll(_ course: Course) {
        if verify() {
            // Enroll student
        }
    }
    
    func verify() -> Bool {
        return true
    }
}

struct InternationalStudent: Student, VerifyStudent {
    var courses: [Course] = []
}
