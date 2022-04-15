import UIKit

let students = ["Alex", "Mary", "John", "Steven"]
let grades = [3.4, 2.8, 3.8, 4]
// will only return a pair that as an equal index in both sequences 
let pair = zip(students, grades)

pair.forEach { studentAndGrade in
    print(studentAndGrade.0) // 0 index = students
    print(studentAndGrade.1) // 1 index = grades
}
