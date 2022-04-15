import UIKit

enum ImageType: String {
    case jpg
    case bmp
    case png
    
    init?(rawValue: String) {
        switch rawValue.lowercased() {
            case "jpg", "jpeg": self = .jpg
            case "bmp", "bitmap": self = .bmp
            case "png": self = .png
            default: return nil
        }
    }
}

func iconName(for fileExtension: String) -> String {
    guard let imageType = ImageType(rawValue: fileExtension) else { return "assetUnknown" }
    
    switch imageType {
        case .jpg:
            return "assetJPG"
        case .bmp:
            return "assetBMP"
        case .png:
            return "assetPNG"
    }
}


iconName(for: "jpg")
iconName(for: "jpeg")
