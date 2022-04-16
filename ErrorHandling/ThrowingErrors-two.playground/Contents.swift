import UIKit
import Foundation

struct Post: Decodable {
    let title: String
    let body: String
}

enum NetworkError: Error {
    case badURL
    case decodingError
    case badRequest
    case noData
    case custom(Error)
}

func getPosts(complete: @escaping (Result<[Post], NetworkError>) -> Void) {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
        complete(.failure(.badURL))
        return
    }
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        
        if let error = error {
            complete(.failure(.custom(error)))
        } else if (response as? HTTPURLResponse)?.statusCode != 200 {
            complete(.failure(.badRequest))
        } else {
            guard let data = data else {
                complete(.failure(.noData))
                return
            }
        
            let posts = try? JSONDecoder().decode([Post].self, from: data)
            if let posts = posts {
                complete(.success(posts))
            } else {
                complete(.failure(.decodingError))
            }
        }
    }.resume()
}

getPosts { (result) in
    switch result {
    case .success(let posts):
        print(posts)
    case .failure(let error):
        print(error)
    }
}
