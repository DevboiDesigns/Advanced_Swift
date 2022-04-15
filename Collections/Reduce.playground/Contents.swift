import UIKit

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
//---------------

let items = [2.0,4.0,5.0,7.0]

let totalItems = items.reduce(0, +)
print(totalItems)
