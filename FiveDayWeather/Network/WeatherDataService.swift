//
//  WeatherDataService.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 22/02/2022.
//

import Combine
import Foundation

final class WeatherDataService: WeatherFetchingService {
    
    // https://api.openweathermap.org/data/2.5/forecast?lat=55.8642&lon=-4.2518&units=metric&appid=53e60d29c7c5e2252dd959f3cfa42a28

    var components: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/forecast"
        // TODO: - lat and long from location service, and appid from constants / env variable for production
        components.queryItems = [URLQueryItem(name: "lat", value: "55.8642"),
                                 URLQueryItem(name: "lon", value: "-4.2518"),
                                 URLQueryItem(name: "appid", value: "53e60d29c7c5e2252dd959f3cfa42a28")]
        return components
    }
    
    func fetchFiveDayWeather() -> AnyPublisher<WeatherData, Error> {
        return URLSession.shared.dataTaskPublisher(for: components.url!)
            .map { $0.data }
            .decode(type: WeatherData.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}

// We can use protocols to describe what our data service offers, allowing us to
// create mock objects in our unit testing which also conform to this protocol
protocol WeatherFetchingService {
    func fetchFiveDayWeather() -> AnyPublisher<WeatherData, Error>
}
