import UIKit

//struct Movie: Codable {
//    let name: String
//    init(_ name: String) { self.name = name }
//}
//
//func seralizeToData<T: Codable>(_ value: T) -> Data? {
//    return try? JSONEncoder().encode(value)
//}
//
//print(seralizeToData(Movie("Batman")))


protocol Fly { func fly() }
protocol Teleport { func teleport() }
protocol Strength { func throwObject() }

typealias SuperHero = Fly & Teleport & Strength

struct Electronman: SuperHero {
    func fly() { }
    func teleport() { }
    func throwObject() { }
}

struct Superman: Fly {
    func fly() { }
}

func attack<T: SuperHero>(value: T) {
    
}

let electronman = Electronman()
let superman = Superman()
attack(value: superman) // will not compile
attack(value: electronman)
