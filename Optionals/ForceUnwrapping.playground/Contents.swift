import UIKit

//MARK: if any other way to unwrap, DO NOT force unwrap

struct Student {
    let firstname: String
    let lastname: String
    let grade: String?
}

let student = Student(firstname: "John", lastname: "Doe", grade: nil)

//print(student.grade!) -- DO NOT

guard let url = URL(string: "https:// sf ww.google.com") else {
    fatalError("URL is not defined!") // will still crash app
}
print(url)
