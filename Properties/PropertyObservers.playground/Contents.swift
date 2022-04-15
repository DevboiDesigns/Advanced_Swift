import UIKit

struct Website {
    
    init(url: String) {
        
        // will get called when init exits
        defer { self.url = url }
        
        self.url = url
    }
    
    var url: String {
        
        willSet {
            // fired before new value is give to property
            // newValue - to get new value of property
        }
        
        // didSet is not called when creating an instance
        
        didSet {
            url = url.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? url
        }
    }
}

var website = Website(url: "www.movies.com/?search=Lord of the Rings")
print(website) // Website(url: "www.movies.com%2F%3Fsearch=Lord%20of%20the%20Rings")

