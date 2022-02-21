//
//  WeatherData.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 21/02/2022.
//

import Foundation

// MARK: - WeatherData
struct WeatherData: Codable {
    let cod: String // Internal parameter
    let message: Int //  Internal parameter
    let timeStampsReturned: Int 
    let list: [List]
    let city: City

    enum CodingKeys: String, CodingKey {
        case cod = "cod"
        case message = "message"
        case timeStampsReturned = "cnt"
        case list = "list"
        case city = "city"
    }
}

// MARK: - City
struct City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: Int
    let sunset: Int

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case coord = "coord"
        case country = "country"
        case population = "population"
        case timezone = "timezone"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
}

// MARK: - Coord
struct Coord: Codable {
    let lat: Double
    let lon: Double

    enum CodingKeys: String, CodingKey {
        case lat = "lat"
        case lon = "lon"
    }
}

// MARK: - List
struct List: Codable {
    let dt: Int // Time of data forecasted, unix, UTC
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let visibility: Int
    let pop: Double
    let snow: Rain?
    let sys: Sys
    let dtTxt: String
    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case main = "main"
        case weather = "weather"
        case clouds = "clouds"
        case wind = "wind"
        case visibility = "visibility"
        case pop = "pop"
        case snow = "snow"
        case sys = "sys"
        case dtTxt = "dt_txt"
        case rain = "rain"
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int

    enum CodingKeys: String, CodingKey {
        case all = "all"
    }
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int // Atmospheric pressure on the sea level by default, hPa
    let seaLevel: Int // Atmospheric pressure on the sea level, hPa
    let grndLevel: Int //  Atmospheric pressure on the ground level, hPa
    let humidity: Int // Humidity, %
    let tempKf: Double //  Internal parameter

    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity = "humidity"
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let mmVolumeOfRainInLastThreeHours: Double

    enum CodingKeys: String, CodingKey {
        case mmVolumeOfRainInLastThreeHours = "3h"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let partOfDay: PartOfDay // Part of the day (n - night, d - day)

    enum CodingKeys: String, CodingKey {
        case partOfDay = "pod"
    }
}

enum PartOfDay: String, Codable {
    case day = "d"
    case night = "n"
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main: MainConditionsEnum  // Group of weather parameters (Rain, Snow, Extreme etc.)
    let weatherDescription: String // Weather condition within the group.
    let icon: String // Weather icon id

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case main = "main"
        case weatherDescription = "description"
        case icon = "icon"
    }
}

// https://openweathermap.org/weather-conditions#Weather-Condition-Codes-2
enum MainConditionsEnum: String, Codable {
    case thunderstorm = "Thunderstorm" // icon code 11d
    case drizzle = "Drizzle"           //  09d
    case rain = "Rain"                 // 10d 
    case snow = "Snow"
    case mist = "Mist"
    case smoke = "Smoke"
    case haze = "Haze"
    case dust = "Dust"
    case fog = "Fog"
    case sand = "Sand"
    case ash = "Ash"
    case squall = "squall"
    case tornado = "Tornado"
    case clear = "Clear"
    case clouds = "Clouds"
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Int
    let gust: Double

    enum CodingKeys: String, CodingKey {
        case speed = "speed"
        case deg = "deg"
        case gust = "gust"
    }
}
