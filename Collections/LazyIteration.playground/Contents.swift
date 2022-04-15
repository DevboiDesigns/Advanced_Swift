import UIKit

let indexes = 1..<5000

let images = indexes.lazy.filter { index -> Bool in
    print("[filter]")
    // anything divisble by 2
    return index % 2 == 0
}.map { index -> String in
    print("[map]")
    return "image_\(index)"
}

let lastThreeImages = images.suffix(3)

//lastThreeImages.forEach { image in
//    print(image)
//}

lastThreeImages.forEach { print($0) }
