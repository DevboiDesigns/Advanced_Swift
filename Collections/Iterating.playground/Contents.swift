import UIKit

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
 ----------------------------- Apple SDK protocol
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
