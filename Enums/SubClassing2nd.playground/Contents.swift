import Foundation

class User {
    var name: String
    var courses: [String]
    
    init(name: String, courses: [String]) {
        self.name = name
        self.courses = courses
    }
}

class Teacher: User {

}

class Student: User {

}
