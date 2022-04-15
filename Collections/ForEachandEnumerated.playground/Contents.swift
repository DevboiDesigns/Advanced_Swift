import UIKit

struct Movie {
    let title: String
    let genre: String
}

var movies = [
    Movie(title: "Lord of the Rings", genre: "Fiction"),
    Movie(title: "ET", genre: "Fiction"),
    Movie(title: "Finding Nemo", genre: "Kids"),
    Movie(title: "Cars", genre: "Kids")
]

movies.forEach { movie in
    addToFav(movie)
}


func addToFav(_ movie: Movie) { }

// Get Access to Index with enumerated
movies.enumerated().forEach { (index, movie) in
    print("Movie: index - \(index), title - \(movie.title)")
}
