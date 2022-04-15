# Advanced-Swift 
 Course on Intermediate to Advanced swift techniques
 [Udemy](https://www.udemy.com/course/swift-for-intermediate-and-advanced-ios-developers/)

 ## Collections

 ### iterating 
 ```swift
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

 ### filter 
 ```swift
var names = ["Alex", "John", "Steven", "Mary"]

let finalNames = names.filter { name in
    return name.count > 4
}
```
```swift

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

 ### forEach and enumerated
 ```swift
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

movies.forEach { movie in
    addToFav(movie)
}


func addToFav(_ movie: Movie) { }

// Get Access to Index with enumerated
// ---------------------------returns a Tuple (a, b)
movies.enumerated().forEach { (index, movie) in
    print("Movie: index - \(index), title - \(movie.title)")
}
 ```

 ### lazy iteration 
 when only needing access to small amounts of large amounts of data

 ```swift
let indexes = 1..<5000

let images = indexes.lazy.filter { index -> Bool in
    print("[filter]")
    // anything divisble by 2
    return index % 2 == 0
}.map { index -> String in
    print("[map]")
    return "image_\(index)"
}

let lastThreeImages = images.suffix(3)

//lastThreeImages.forEach { image in
//    print(image)
//}

lastThreeImages.forEach { print($0) }

```
 ### reduce
 will reduce array to 1 value

 ```swift
struct Item {
    let name: String
    let price: Double
}

struct Cart {
    // can only be set from with Cart struct
    private(set) var items: [Item] = []
    
    mutating func addItem(_ item: Item) {
        items.append(item)
    }
    
    // reduce - will reduce array to 1 value
    var total: Double {
        //---------- 0 init value -------- Result type
        items.reduce(0) { (value, item) -> Double in
            return value + item.price
        }
    }
}

var cart = Cart()
cart.addItem(Item(name: "Milk", price: 4.50))
cart.addItem(Item(name: "Bread", price: 2.50))
cart.addItem(Item(name: "Eggs", price: 12.00))

print(cart.total)
```
```swift
let items = [2.0,4.0,5.0,7.0]

let totalItems = items.reduce(0, +)
print(totalItems)
 ```

 ### reduce(into: )
 ```swift
 let ratings = [4, 8.5, 9.5, 2, 6, 3, 5.5, 7, 2.8, 9.8, 5.9, 1.5]

// -------------------------------------------------inout - results must/can be modified inside closure
let results = ratings.reduce(into: [:]) { (results: inout [String: Int], rating: Double) in
    
    switch rating {
        case 1..<4: results["Very Bad", default: 0] += 1
        case 4..<6: results["Ok", default: 0] += 1
        case 6..<8: results["Good", default: 0] += 1
        case 8..<11: results["Excellent", default: 0] += 1
        default: break
    }
    // returns the modified results object
}
print(results)
 ```

### zip
 ```swift
let students = ["Alex", "Mary", "John", "Steven"]
let grades = [3.4, 2.8, 3.8, 4]
// will only return a pair that as an equal index in both sequences 
let pair = zip(students, grades)

pair.forEach { studentAndGrade in
    print(studentAndGrade.0) // 0 index = students
    print(studentAndGrade.1) // 1 index = grades
}
 ```

## Functions

### inout 
in-out parameters

```swift
struct User {
    var userID: Int?
    let name: String
}


func saveUser(_ user: inout User) {
    // code to save user
    user.userID = 100
}

var user = User(name: "John Doe")
saveUser(&user) // & = copy of type
```

### nested
functions inside another function

```swift
struct Pizza {
    let sauce: String
    let toppings: [String]
    let crust: String
}

class PizzaBuilder {
   
    func prepare() -> Pizza {
        
        func prepareSauce() -> String {
            return "Tomato Sauce"
        }
        
        func prepareToppings() -> [String] {
            return ["Chicken", "Pesto", "Mushroom"]
        }
        
        func prepareCrust() -> String {
            return "Hand tossed"
        }
        
        let sauce = prepareSauce()
        let toppings = prepareToppings()
        let crust = prepareCrust()
        
        return Pizza(sauce: sauce, toppings: toppings, crust: crust)
    }
    
}

let pizzaBuilder = PizzaBuilder()
let pizza = pizzaBuilder.prepare()
```

### closures
functions as variables, passing functions to functions

```swift
/*
var hello = {
    print("Hello")
}
hello()
*/

/*
var hello: (String) -> () = { name in
    print("Hello \(name)")
}
hello("John")
 */

// If passed more than one parameter use $1, $2 etc
var hello: (String) -> () = { print("Hello \($0)") }

hello("John") // Hello John

var helloOnly: (String) -> () = {  _ in
    print("Hello") }

helloOnly("John") // Hello


// ----- number - times
let power: (Int, Int) -> Int = { number, times in
    number * times
}
let result = power(5, 3)
print(result)

let pow: (Int, Int) -> Int = { $0 * $1 }
let powResult = pow(5, 3)
print(powResult)
```

pass closure into a function - @escaping closures

```swift
func getPosts(complete: @escaping ([String]) -> ()) {

    var posts: [String] = []

    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        posts = ["Hello World", "Introduction to Closures"]
        complete(posts)
    }

}

getPosts { posts in
    print(posts)
}
```

 ## Enums

 ### replacing structs with enums
 ```swift
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
  
 ### hiding types
 ```swift
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
 ### subclassing with enums
 ```swift
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

### sub classing 2
```swift
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
### raw values
#### scenerio 1
```swift
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
```swift
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

## Properties 

### lazy stored properties
will only be initalized once / and accessible immediately after first init (ideal for api call)

```swift
enum Level {
    case easy
    case medium
    case hard
}

struct Exam {
    var level: Level
    
    // lazy = will fetch quetions the 2nd time instantly without api call
    // private(set) = can only set within Exam structure not later
    lazy private(set) var questions: [String] = {
        
        // mock - api fetch time span
        sleep(5)
        
        switch level {
        case .easy:
            return ["What is 1+2", "What is 1+2", "What is 2+2"]
        case .medium:
            return ["What is 11+22", "What is 11+22", "What is 32+42"]
        case .hard:
            return ["What is 122+332", "What is 441+255", "What is 266+250"]
        }
    }()
}


var exam = Exam(level: .easy) // must be mutable - var
print(exam.questions)
print("Wait for 1 second")
sleep(1)
print(exam.questions) // returned instantly

// exam.questions = ["What is the capital of US?"] = NOT Allowed with private(set) property wrapper
```

### computed properties 

```swift
struct Workout {
    let startTime: Date
    let endTime: Date
    
    var timeElapsed: TimeInterval {
        endTime.timeIntervalSince(startTime)
    }
}

let start = Date()
sleep(5)
let end = Date()

let workout = Workout(startTime: start, endTime: end)
//print(workout.endTime.timeIntervalSince(workout.startTime))
print(workout.timeElapsed)
```

```swift
struct CartItem {
    let name: String
    let price: Double
}

struct Cart {
    let items: [CartItem]
    
    var total: Double {
        items.reduce(0) {
            return $0 + $1.price
        }
    }
}

let items = [
    CartItem(name: "Bread", price: 4.50),
    CartItem(name: "Milk", price: 3.50),
    CartItem(name: "Pizza", price: 10.95)
]

let cart = Cart(items: items)
print(cart.total)
```

### property observers

```swift
struct Website {
    
    init(url: String) {
        
        // defer = will get called when init exits - will run didSet when executed 
    
        defer { self.url = url }
        
        self.url = url
    }
    
    var url: String {
        
        willSet {
            // fired before new value is give to property
            // newValue - to get new value of property
        }
        
        // didSet is not called when creating an instance
        
        didSet {
            url = url.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? url
        }
    }
}

var website = Website(url: "www.movies.com/?search=Lord of the Rings")
print(website) // Website(url: "www.movies.com%2F%3Fsearch=Lord%20of%20the%20Rings")
```

## Initializers 