# Advanced-Swift 
 Course on Intermediate to Advanced swift techniques
 [UdemyCourse](https://www.udemy.com/course/swift-for-intermediate-and-advanced-ios-developers/)

 ## Collections

 ### Iterating 
 ```
 let names = ["Alex", "John", "Mary"]

var nameIteratory = names.makeIterator()

while let name = nameIteratory.next() {
    print(name)
}

/*
for name in names {
    print(name)
}
*/

/*
 ----------------------------- Swift protocol
protocol IteratorProtocol {
    associatedtype Element
    
    mutating func next() -> Element?
}
*/

struct Countdown: Sequence {
    
    let start: Int
    
    func makeIterator() -> some IteratorProtocol {
        return CountdownIterator(self)
    }
}

struct CountdownIterator: IteratorProtocol {
    let countdown: Countdown
    var currentValue: Int = 0
    
    init(_ countdown: Countdown) {
        self.countdown = countdown
        self.currentValue = countdown.start
    }
    
    // if mutating a value
    mutating func next() -> Int? {
        if currentValue > 0 {
            let value = currentValue
            currentValue -= 1
            return value
        } else {
            return nil
        }
    }
}


let countdown = Countdown(start: 10)
for count in countdown {
    print(count)
}
 ```

 ### Filter 
 ```
var names = ["Alex", "John", "Steven", "Mary"]

let finalNames = names.filter { name in
    return name.count > 4
}
```
```

struct Movie {
    let title: String
    let genre: String
}

var movies = [
    Movie(title: "Lord of the Rings", genre: "Fiction"),
    Movie(title: "ET", genre: "Fiction"),
    Movie(title: "Finding Nemo", genre: "Kids"),
    Movie(title: "Cars", genre: "Kids")
]

let movieToRemove = Movie(title: "Finding Nemo", genre: "Kids")

movies = movies.filter { movie in
    return movie.title != movieToRemove.title
}

let kidsMovies = movies.filter { movie in
    return movie.genre == "Kids"
}


 ```

 ## Enums

 ### Replacing structs with enums
 ```
 enum Session {
    case keynote(title: String, speaker: String, date: Date, isRecorded: Bool)
    case normal(title: String, speaker: String, date: Date)
    case workshop(title: String, speaker: String, date: Date, isRecorded: Bool)
    case joint(title: String, speakers: [String], date: Date)
}

let keynote = Session.keynote(title: "WWDC 2022", speaker: "Tim Cook", date: Date(), isRecorded: true)

func displaySession(session: Session) {
    switch session {
    case let .keynote(title: title, speaker: speaker, date: date, isRecorded: isRecorded):
        print("\(title) - \(speaker) - \(date) - \(isRecorded)")
    case let .normal(title: title, speaker: speaker, date: date):
        print("\(title) - \(speaker) - \(date)")
    case let .workshop(title: title, speaker: speaker, date: date, isRecorded: isRecorded):
        print("\(title) - \(speaker) - \(date) - \(isRecorded)")
    case let .joint(title: title, speakers: speakers, date: date):
        print("\(title) - \(speakers) - \(date)")
    }
}
 ```
  
 ### Hiding types
 ```
struct Teacher {
    let name: String
    let courses: [String]
}

struct Student {
    let name: String
    let courses: [String]
    var grade: String?
}


let teacher = Teacher(name: "John Doe", courses: ["Math", "Science"])
let student = Student(name: "John Doe", courses: ["Math", "Science"])

enum User {
    case teacher(Teacher)
    case student(Student)
}

let allUsers = [User.teacher(teacher), User.student(student)]

for user in allUsers {
    switch user {
    case .teacher(let teacher):
        print(teacher.courses)
    case .student(let student):
        print(student.grade ?? "")
    }
}
 ```
 ### Subclassing with enums
 ```
 enum Ticket {
    case economy(Economy)
    case firstClass(FirstClass)
    case bussiness(Business)
    case international(International)
}

struct Economy {
    let departure: String
    let arrival: String
}

struct FirstClass {
    let departure: String
    let arrival: String
    let meal: Bool
}

struct Business {
    let departure: String
    let arrival: String
    let meal: Bool
    let chargingPorts: Bool
}

struct International {
    let departure: String
    let arrival: String
    let meal: Bool
    let chargingPorts: Bool
    let baggageAllowed: Bool
}

let ticket = Ticket.bussiness(Business(departure: "Houston", arrival: "Denver", meal: true, chargingPorts: true))

func checkIn(ticket: Ticket) {
    switch ticket {
    case .economy(let economy):
        print("\(economy)")
    case .firstClass(let firstClass):
        print("\(firstClass)")
    case .bussiness(let bussiness):
        print("\(bussiness)")
    case .international(let international):
        print("\(international)")
    }
}
 ```

### Sub classing 2
```
struct Student {
    let name: String
    let courses: [String]
    let isFullTime: Bool
}

struct Teacher {
    let name: String
    let courses: [String]
    let isFullTime: Bool
}

struct Staff {
    let name: String
    let isFullTime: Bool
}

enum User {
    case student(Student)
    case teacher(Teacher)
    case staff(Staff)
}

func updateProfile(user: User) {
    switch user {
    case .student(let student):
        print(student)
    case .teacher(let teacher):
        print(teacher)
    case .staff(let staff):
        print(staff)
    }
}

updateProfile(user: User.student(Student(name: "John Doe", courses: ["Math", "Science"], isFullTime: true)))
```
### Raw values
#### scenerio 1
```
enum NetworkError: Error {
    case badURL
    case decodingError
}

//enum TemperatureUnit: String {
//    case imperial = "fahrenheit"
//    case metric = "celsius"
//}

// Variables updated by third party - scenerio
enum TemperatureUnit: String {
    case imperial = "F"
    case metric = "C"
}

private func getWeatherURL(unit: TemperatureUnit) -> URL? {
    switch unit {
    case .imperial:
        return URL(string: "www.weather.com/?unit=fahrenheit")
    case .metric:
        return URL(string: "www.weather.com/?unit=celsius")
    }
}

func getWeather(unit: TemperatureUnit) throws {
    guard let url = getWeatherURL(unit: unit) else {
        throw NetworkError.badURL
    }
    print(url)
    // code to call weather api
}

/*
func getWeather(unit: TemperatureUnit) throws {
    guard let url = URL(string: "www.weather.com/?unit=\(unit.rawValue)") else {
        throw NetworkError.badURL
    }
    print(url)
    // code to call weather api
}
*/

do {
    try getWeather(unit: .imperial)
} catch {
    print(error)
}
```

#### scenerio 2
```
enum ImageType: String {
    case jpg
    case bmp
    case png
    
    init?(rawValue: String) {
        switch rawValue.lowercased() {
            case "jpg", "jpeg": self = .jpg
            case "bmp", "bitmap": self = .bmp
            case "png": self = .png
            default: return nil
        }
    }
}

func iconName(for fileExtension: String) -> String {
    guard let imageType = ImageType(rawValue: fileExtension) else { return "assetUnknown" }
    
    switch imageType {
        case .jpg:
            return "assetJPG"
        case .bmp:
            return "assetBMP"
        case .png:
            return "assetPNG"
    }
}


iconName(for: "jpg")
iconName(for: "jpeg")
```