import UIKit

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
