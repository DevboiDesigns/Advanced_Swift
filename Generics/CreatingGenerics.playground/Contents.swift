import UIKit

enum NetworkError: Error {
    case badURL
}

struct Post: Codable {
    let title: String
}

// similar to Result type
enum Callback<T: Codable, K: Error> {
    case success(T)
    case failure(K)
}


func getPosts(complete: (Callback<[Post], NetworkError>) -> Void) {
    // get posts
    let posts = [
        Post(title: "Hello world"), Post(title: "Intro to Swift")
    ]
    // if success
    complete(.success(posts))
    // if error
    complete(.failure(.badURL))
}

getPosts { (result) in
    switch result {
    case .success(let posts):
        print(posts)
    case .failure(let error):
        print(error)
    }
}
