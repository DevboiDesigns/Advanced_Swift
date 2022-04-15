import UIKit

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


// --------------------------------------- passing a closure to Function

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
