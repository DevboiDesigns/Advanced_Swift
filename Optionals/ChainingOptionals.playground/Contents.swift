import UIKit

struct Grade {
    let gpa: Double?
    let letter: String?
}

struct Student {
    let firstname: String
    let lastname: String
    let grade: Grade?
}

let student = Student(firstname: "John", lastname: "Doe", grade: Grade(gpa: 3.2, letter: "B"))

print(student.grade?.gpa ?? "N/A") // will unwrap to non optional
