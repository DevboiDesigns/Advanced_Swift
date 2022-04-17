import UIKit

enum Card: Comparable {
    case ace
    case king
    case queen
    
    // --- less than <
    static func <(lhs: Card, rhs: Card) -> Bool {
        switch (lhs, rhs) {
            // left hand side is less < than righ = lhs, rhs
        case (king, ace): return true
        case (queen, king): return true
        case (queen, ace): return true
        default: return false
            
        }
    }
}

func lowest<T: Comparable>(list: [T]) -> T? {
    let sortedList = list.sorted { return $0 < $1 }
    
    return sortedList.first
}

let queen = Card.queen
let ace = Card.ace

if queen < ace {
    print("Queen is less")
}

print(lowest(list: [Card.ace, Card.king, Card.queen]))
