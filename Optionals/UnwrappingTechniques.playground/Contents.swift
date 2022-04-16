import UIKit

//MARK: custom description when printing to console
struct Student: CustomStringConvertible {
    // required init
    var description: String {
        var studentDescription = "\(firstname)"
        
        // -- variable shadwoing
        if let middlename = middlename {
            studentDescription.append(" \(middlename)")
        }
        
        studentDescription.append(" \(lastname)")
        
        if let grade = grade {
            studentDescription.append(" - Grade: \(grade)")
        }
    
        return studentDescription
    }
    
    let firstname: String
    let lastname: String
    var middlename: String?
    var grade: String?
}

var student = Student(firstname: "John", lastname: "Doe", middlename: "Smith", grade: "A")

print(student) //prints: John Smith Doe - Grade: A


