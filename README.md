# Advanced-Swift 
 * Course on Intermediate to Advanced swift techniques
 [Udemy](https://www.udemy.com/course/swift-for-intermediate-and-advanced-ios-developers/)
 * `Swift5`
 * *work in progress*

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
 *when only needing access to small chunks of large amounts of data*

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
 *will reduce array to 1 value*

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
**in-out parameters**

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
**functions inside another function**

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
**functions as variables, passing functions to functions**

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

**pass closure into a function** - *@escaping closures*

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
### subclassing

 ##### scenerio 1
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

##### scenerio 2
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
##### scenerio 1
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

##### scenerio 2
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
*will only be initalized once / and accessible immediately after first init (ideal for api call)*

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

### in structs
```swift
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
```

### convience initializers

```swift

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
```

### subclassing

```swift
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
```
[subclassing-screenshot](Initializers/subclassing-init.png)

### required initializers 

```swift 
protocol CarType {
    init(make: String, model: String)
}


//MARK: - always mark as Final until you know if inheriting
final class Car: CarType {
    var make: String
    var model: String
    var color: String
    
    init(make:String, model: String, color: String) {
        self.make = make
        self.model = model
        self.color = color
    }
    
    required convenience init(make: String, model: String) {
        self.init(make: make, model: model, color: "White")
    }
    
    /*
    class func makeCar(make: String, model: String) -> Self {
        let car = self.init(make: make, model: model)
        // setup engine
        // setup fuel
        // setup tires
        return car
    }
     */
}

let car = Car(make: "Honda", model: "Accord")
```

## Optionals

### unwrapping techniques 

```swift 
struct Student {
    let firstname: String
    let lastname: String
    var middlename: String?
    var grade: String?
}

var student = Student(firstname: "John", lastname: "Doe")
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
```

### variable shadowing 

*custom description when printing to console* - `CustomStringConvertible`

```swift 
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
```

### returning optional strings 

```swift 
struct Student {
    let firstname: String?
    let lastname: String?
    
    var displayName: String? {
        switch (firstname, lastname) {
            case let (first?, last?): return "\(first) \(last)"
            case let (first?, nil): return first
            case let (nil, last?): return last
            default: return nil
        }
    }
}

var student = Student(firstname: nil, lastname: nil)

func createGreetingMessage(student: Student) -> String {
    let message = """
        Dear \(student.displayName ?? "Student"), Welcome to Swift University
        """
    return message
}

let message = createGreetingMessage(student: student)
print(message)
```

### chaining optionals

```swift
struct Grade {
    let gpa: Double?
    let letter: String?
}

struct Student {
    let firstname: String
    let lastname: String
    let grade: Grade?
}

let student = Student(firstname: "John", lastname: "Doe", grade: Grade(gpa: 3.2, letter: "B"))

print(student.grade?.gpa ?? "N/A") // will unwrap to non optional --- prints: 3.2
```

### booleans

`RawRepresentable`

```swift
// RawRepresentable - for booleans
enum UserAgreement: RawRepresentable {
    case accepted
    case rejected
    case notSet
    
    init(rawValue: Bool?) {
        switch rawValue {
            case true?: self = .accepted
            case false?: self = .rejected
            default: self = .notSet
        }
    }
    
    var rawValue: Bool? {
        switch self {
            case .accepted: return true
            case .rejected: return false
            case .notSet: return nil
        }
    }
}


let userAgreement = UserAgreement(rawValue: nil)

switch userAgreement {
    case .accepted:
        print("accepted")
    case .rejected:
        print("rejected")
    case .notSet:
        print("notSet")
}
```

### force unwrapping

**if any other way to unwrap, DO NOT force unwrap**

```swift
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
```

## Error Handling 

### types of errors

* syntax errors

[Syntax Error](ErrorHandling/syntax-error.png)
  
```swift
func calculateAPR(balance: Double) -> Double {
    // calculate
    return 10.0
}

calculateAPR(balance: "5000")
//MARK: ERROR Message: Cannot convert value of type 'String' to expected argument type 'Double'
```

* runtime errors

[Runtime Error](ErrorHandling/runtime-error.png)
  
```swift
let airports = [
    "IAH": "Intercontinental Airport",
    "JFK": "John F Kennedy, International Airport",
    "SEA": "Seattle-Tacoma, International Airport",
]

let name = airports["HOBBY"]!
//MARK: ERROR Message: error: Execution was interrupted, reason: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0).
//The process has been left at the point where it was interrupted, use "thread return -x" to return to the state before expression evaluation.

// CONSOLE: __lldb_expr_5/TypesOfErrors.playground:9: Fatal error: Unexpectedly found nil while unwrapping an Optional value
```

* logic errors

```swift
struct Account {
    var balance: Double
}

extension Account {
    
    mutating func deposit(_ amount: Double) {
        balance += amount
    }
    
    mutating func withdraw(_ amount: Double) {
        // ---  (-)  --- error 
        balance += amount
    }
    
    func calculateInterestEarned() -> Double {
        return (balance * (0.1/100))
    }
}

```

### throwing errors

##### client side

```swift
enum BankAccountError: Error {
    case insuficientFunds
    case accountClosed
}

class BankAccount {
    
    var balance: Double
    
    init(balance: Double) {
        self.balance = balance
    }
    
    func withdraw(amount: Double) throws {
        if balance < amount {
            // throw an error
            throw BankAccountError.insuficientFunds
        }
        
        balance -= amount
    }
}


let account = BankAccount(balance: 100)

do {
    try account.withdraw(amount: 300)
} catch {
    print(error)
}
```

##### network error

```swift
struct Post: Decodable {
    let title: String
    let body: String
}

enum NetworkError: Error {
    case badURL
    case decodingError
    case badRequest
    case noData
    case custom(Error)
}

func getPosts(complete: @escaping (Result<[Post], NetworkError>) -> Void) {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
        complete(.failure(.badURL))
        return
    }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        
        if let error = error {
            complete(.failure(.custom(error)))
        } else if (response as? HTTPURLResponse)?.statusCode != 200 {
            complete(.failure(.badRequest))
        } else {
            guard let data = data else {
                complete(.failure(.noData))
                return
            }
        
            let posts = try? JSONDecoder().decode([Post].self, from: data)
            if let posts = posts {
                complete(.success(posts))
            } else {
                complete(.failure(.decodingError))
            }
        }
    }.resume()
}

getPosts { (result) in
    switch result {
    case .success(let posts):
        print(posts)
    case .failure(let error):
        print(error)
    }
}
```

### using do-catch

**error propagation** - *push errors up to be handled* 

```swift
enum PizzaError: Error {
    case burnt(String)
    case noToppings(String)
}

struct Pizza {
    let dough: String
    let toppings: [String]
}

struct PizzaBuilder {
    
    func prepare() -> Pizza? {
        
        do {
            let dough = try prepareDough()
            let toppings = try prepareToppings()
            return Pizza(dough: dough, toppings: toppings)
        } catch {
            print(error)
            print("Unable to prepare")
            return nil
        }
    }
    
    private func prepareDough() throws -> String {
        // prepare dough
        throw PizzaError.burnt("Burnt the pizza dough")
     
    }
    
    private func prepareToppings() throws -> [String] {
        // prepare dough
        throw PizzaError.noToppings("Chicken & Onions are n/a")
     
    }
}

let pizza = PizzaBuilder()
pizza.prepare()
```

### validity with type 

```swift
enum ValidationError: Error {
    case noEmptyValueAllowed
    case invalidEmail
}

// Validating Types ------------------------------------------------

struct Email {
    var text: String
    
    init(_ text: String) throws {
        guard !text.isEmpty else { throw ValidationError.noEmptyValueAllowed }
        
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        
        let isValid = emailPredicate.evaluate(with: text)
        
        if isValid {
            self.text = text
        } else {
            throw ValidationError.invalidEmail
        }
    }
}


do {
    let email = try Email("johndoe@gmail.com")
    print(email)
} catch {
    print(error)
}
```


### try? & try! 

##### try?
* do not need error message - *will just return nil and not stop the app*

```swift
let email = try? Email("sdfj")
```

##### try!
* only use if you are 💯 sure it will not be nill - *will crash if not*
  
```swift
let email = try! Email("sdfj")
```

## Protocols

*using protocols allows you to add different types to the same collection and process together* 

### usage 

```swift
extension Date {
    static func fiveHoursFromNow() -> Date {
        return Date().addingTimeInterval(5 * 60 * 60)
    }
}

protocol AirlineTicket {
    var name: String { get }
    var departure: Date? { get set }
    var arrival: Date? { get set }
}

struct Economy: AirlineTicket {
    let name = "ECON"
    var departure: Date?
    var arrival: Date?
}

struct Business: AirlineTicket {
    let name = "BUS"
    var departure: Date?
    var arrival: Date?
}

struct First: AirlineTicket {
    let name = "FIRST"
    var departure: Date?
    var arrival: Date?
}


class CheckoutService {
    
    var tickets: [AirlineTicket]
    
    init(tickets: [AirlineTicket]) {
        self.tickets = tickets
    }
    
    func addTicket(_ ticket: AirlineTicket) {
        self.tickets.append(ticket)
    }
    
    func processTickets() {
        tickets.forEach { print($0) }
    }
}


let economyTickets = [
    Economy(departure: Date(), arrival: Date.fiveHoursFromNow())
]

let service = CheckoutService(tickets: economyTickets)
service.addTicket(First(departure: Date(), arrival: Date.fiveHoursFromNow()))
service.processTickets()
```

### generics 

**associated types** - *gives flexibity* - the class that will dictate what the type will be 

```swift 
protocol Parser {
    
    associatedtype Input
    associatedtype Output
    
    func parse(input: Input) -> Output
}

class TextFileParser: Parser {
    func parse(input: String) -> String {
        return ""
    }
}

class HTMLParser: Parser {
    func parse(input: String) -> [String] {
        return [""]
    } 
}

```

```swift
class JsonParser: Parser {
    
    typealias Input = String
    typealias Output = [String: String]
    
    func parse(input: Input) -> Output {
        return [:]
    }
}
```

```swift
func runParser<P: Parser>(parser: P, input: [P.Input]) where P.Input == JsonParser {
    input.forEach {
       _ = parser.parse(input: $0)
    }
}
```

### extensions

##### part one 

```swift
protocol Parser {
    associatedtype Input
    associatedtype Output
    
    func parse(input: Input) -> Output
}

// if you do not implement, then the default is used
extension Parser {
    
    func parse(input: String) -> [String]  {
        return ["<html></html>", "<p></p>"]
    }
}

class XHTMLParser: Parser {
    
}

let xhtmlParser = XHTMLParser()
xhtmlParser.parse(input: "")
```

##### part two

*creating default implementations* 

```swift
protocol Account {
    
    var balance: Double { get set }
    
    mutating func deposit(_ amount: Double)
    mutating func withdraw(_ amount: Double)
    func calculateInterestEarned() -> Double
    func transfer(from: Account, to: Account, amount: Double)
    
}
```

**extensions become default implementation**

```swift
extension Account {
    mutating func deposit(_ amount: Double) { balance += amount }
    mutating func withdraw(_ amount: Double) { balance -= amount }
    func calculateInterestEarned() -> Double { return (balance * (0.1/100)) }
}

struct CheckingAccount: Account {
    var balance: Double
    
    func transfer(from: Account, to: Account, amount: Double) {
        //
    }
    
    func calculateInterestEarned() -> Double { return (balance * (0.2/100)) }
}


struct MoneyMarketAccount: Account {
    var balance: Double
    
    func transfer(from: Account, to: Account, amount: Double) {
        //
    }
    
    func calculateInterestEarned() -> Double { return (balance * (0.4/100)) }
}
```

##### part three

```swift
protocol Account {
    var balance: Double { get set }
    mutating func deposit(_ amount: Double)
    mutating func withdraw(_ amount: Double)
    func calculateInterestEarned() -> Double
    func transfer(from: Account, to: Account, amount: Double)
}

extension Account {
    mutating func deposit(_ amount: Double) { balance += amount }
    mutating func withdraw(_ amount: Double) { balance -= amount }
    func calculateInterestEarned() -> Double { return (balance * (0.1/100)) }
}

struct VerificationRequest {
    let accounts: [Account]
}

struct VerificationResponse {
    let verified: Bool
}

// 2nd Protocol
protocol Verification {
    func performVerification(_ request: VerificationRequest, complete: (VerificationResponse) -> Void)
}

extension Verification {
    func performVerification(_ request: VerificationRequest, complete: (VerificationResponse) -> Void) {
        // perform verificaton logic
    }
}


struct CheckingAccount: Account, Verification {
    var balance: Double
    
    func transfer(from: Account, to: Account, amount: Double) {
        self.performVerification(VerificationRequest(accounts: [from, to])) { (response) in
            if response.verified {
                // transfer funds
            }
        }
    }
}
```