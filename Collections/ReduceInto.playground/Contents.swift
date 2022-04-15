import UIKit

let ratings = [4, 8.5, 9.5, 2, 6, 3, 5.5, 7, 2.8, 9.8, 5.9, 1.5]

// -------------------------------------------------inout - results must/can be modified inside closure
let results = ratings.reduce(into: [:]) { (results: inout [String: Int], rating: Double) in
    
    switch rating {
        case 1..<4: results["Very Bad", default: 0] += 1
        case 4..<6: results["Ok", default: 0] += 1
        case 6..<8: results["Good", default: 0] += 1
        case 8..<11: results["Excellent", default: 0] += 1
        default: break
    }
    // returns the modified results object
}
print(results)
