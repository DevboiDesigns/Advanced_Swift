import UIKit

let numbers = [1, 2, 3, 4, 5, 6]
// Loop
var doubleNumbers: [Int] = []
for number in numbers {
    doubleNumbers.append(number * 2)
}
doubleNumbers
// Map
//var doubleNumbersMap = numbers.map { (number) -> Int in
//    return number * 2
//}

/// Variation 1 
//var doubleNumbersMap = numbers.map { (number) in
//    number * 2
//}

/// Variation 2
var doubleNumbersMap = numbers.map { $0 * 2 }
doubleNumbersMap

let pairs = [[1,5], [7,9], [11,15]]
//var sums = pairs.map { pair in
//    pair[0] + pair[1]
//}

var sums = pairs.map { $0[0] + $0[1] }
sums

let groups = [[1,3,9,11], [5,7]]
var groupSum = groups.map { group -> Int in
    var sum = 0
    for num in group {
        sum += num
    }
    return sum
}
groupSum


let stringValues = ["1", "two", "3", "4", "five"]
//let intValues = stringValues.map { Int($0) }  // Optional
let intValues = stringValues.map { Int($0) ?? -1 }  // Non-Optional
intValues

struct User {
    var name: String
    var age: Int
}

let users = [
    User(name: "Curly", age: 15),
    User(name: "Larry", age: 18),
    User(name: "Moe", age: 18)
]

let names = users.map { $0.name }
