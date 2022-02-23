//
//  WeatherDataService.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 22/02/2022.
//

import Combine
import Foundation

final class WeatherDataService: WeatherFetchingService {
    
    var latString: String = "0.0"
    var longString: String = "0.0"
    
    var components: URLComponents {
        var components = URLComponents()
        components.scheme = Constants.API.defaultScheme
        components.host = Constants.API.defaultHost
        components.path = Constants.API.defaultPath
        // TODO: - lat and long from location service, and appid from constants / env variable for production
        components.queryItems = [URLQueryItem(name: "lat", value: latString),
                                 URLQueryItem(name: "lon", value: longString),
                                 URLQueryItem(name: "units", value: "metric"),
                                 URLQueryItem(name: "appid", value: Constants.API.apiKey)]
        return components
    }
    
    func fetchFiveDayWeather(lat: Double, long: Double) -> AnyPublisher<WeatherData, Error> {
        self.latString = String(lat)
        self.longString = String(long)
        
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
    func fetchFiveDayWeather(lat: Double, long: Double) -> AnyPublisher<WeatherData, Error>
}
