import UIKit

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
