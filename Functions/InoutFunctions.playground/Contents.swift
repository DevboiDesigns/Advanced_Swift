import UIKit

struct User {
    var userID: Int?
    let name: String
}


func saveUser(_ user: inout User) {
    // code to save user
    user.userID = 100
}

var user = User(name: "John Doe")
saveUser(&user) // & = copy of type


print(user)
