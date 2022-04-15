import UIKit

enum NetworkError: Error {
    case badURL
    case decodingError
}

//enum TemperatureUnit: String {
//    case imperial = "fahrenheit"
//    case metric = "celsius"
//}

// Variables updated by third party - scenerio
enum TemperatureUnit: String {
    case imperial = "F"
    case metric = "C"
}

private func getWeatherURL(unit: TemperatureUnit) -> URL? {
    switch unit {
    case .imperial:
        return URL(string: "www.weather.com/?unit=fahrenheit")
    case .metric:
        return URL(string: "www.weather.com/?unit=celsius")
    }
}

func getWeather(unit: TemperatureUnit) throws {
    guard let url = getWeatherURL(unit: unit) else {
        throw NetworkError.badURL
    }
    print(url)
    // code to call weather api
}

/*
func getWeather(unit: TemperatureUnit) throws {
    guard let url = URL(string: "www.weather.com/?unit=\(unit.rawValue)") else {
        throw NetworkError.badURL
    }
    print(url)
    // code to call weather api
}
*/

do {
    try getWeather(unit: .imperial)
} catch {
    print(error)
}

