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

//MARK: ------------------ Convience initializers


class Car {
    var make: String
    var model: String
    var color: String
    
    init(make:String, model: String, color: String) {
        self.make = make
        self.model = model
        self.color = color
    }
    
    convenience init(make: String, model: String) {
        self.init(make: make, model: model, color: "White")
    }
}

let car = Car(make: "Honda", model: "Accord")
