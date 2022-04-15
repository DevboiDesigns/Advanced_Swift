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


//MARK: ------------------------------- Subclassing

class Tesla: Car {
    var range: Double
    
     init(make: String, model: String, color: String, range: Double) {
        self.range = range
        super.init(make: make, model: model, color: color)
    }
    
     override init(make: String, model: String, color: String) {
       self.range = 300
       super.init(make: make, model: model, color: color)
   }
}

let tesla = Tesla(make: "", model: "", color: "", range: 0)
