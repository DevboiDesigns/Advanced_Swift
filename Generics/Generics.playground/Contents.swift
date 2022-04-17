import UIKit

struct Movie {
    let name: String
    
    init(_ name: String) {
        self.name = name
    }
}

let numbers = [1,2,3,4,5,6,7,8,9]
let names = ["Alex", "John", "Mary", "Steve"]
let movies = [Movie("Batman"), Movie("Spiderman"), Movie("Superman")]

// <T> T = can be any name
func firstLast<T>(_ list: [T]) -> (T, T) {
    return (list[0], list[list.count - 1])
}

let (first, last) = firstLast(numbers)
let (nameFirst, nameLast) = firstLast(names)
let (firstMovie, lastMovie) = firstLast(movies)

print(first)
print(last)
print(nameFirst)
print(nameLast)
print(firstMovie)
print(lastMovie)
