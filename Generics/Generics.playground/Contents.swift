import UIKit

// can comparable
struct Movie: Equatable {
    let name: String
    init(_ name: String) { self.name = name }
}

let numbers = [1,2,3,4,5,6,7,8,9]
let names = ["Alex", "John", "Mary", "Steve"]
let movies = [Movie("Batman"), Movie("Spiderman"), Movie("Superman")]

// Equatable constrains to comparable types
func findIndex<T: Equatable>(from list: [T], valueToFind: T) -> Int? {
    
    return list.firstIndex { (item) -> Bool in
        return item == valueToFind
    }
}

let batmanMovie = Movie("Batman")
let movie = findIndex(from: movies, valueToFind: batmanMovie)
//print(findIndex(from: movies, valueToFind: batmanMovie))
print(movie ?? Movie(""))
