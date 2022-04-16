import UIKit

struct Student {
    let name: String
    let lastname: String
    var middlename: String?
    var grade: String?
}

var student = Student(name: "John", lastname: "Doe")
student.middlename = "Johnson"
student.grade = "A"

//MARK:  --------------------------------------------  if let
if let middlename = student.middlename, let grade = student.grade {
    print("[middlename] \(middlename) [grade] \(grade)")
}

if let _ = student.grade {
    print("Student has a grade")
}

//MARK:  -------------------------------------------- guard statement
func displayStudent(student: Student) {
    guard let middlename = student.middlename, let grade = student.grade else { return }
    print("[middlename] \(middlename) [grade] \(grade)")
    
}
displayStudent(student: student)

//print(student.middlename ?? "")
