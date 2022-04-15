import UIKit

struct Student {
    let firstname: String
    let lastname: String
    let grade: String
    
    
}

extension Student {
    
    // will allow you to keep the default initializer
    
    init(firstname: String, lastname: String) {
        self.firstname = firstname
        self.lastname = lastname
        self.grade = ""
    }
}

let student = Student(firstname: "", lastname: "")
let otherStudent = Student(firstname: "", lastname: "", grade: "")

