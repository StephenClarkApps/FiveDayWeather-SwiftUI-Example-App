//
//  APICaller.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 21/02/2022.
//

import Combine
import Foundation

class APICaller {
    static let sharedInstance = APICaller()
    
    func fetchWeather() -> Future<WeatherData, Error> {
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                promise(.success(WeatherData(cod: "200",
                                             message: 0,
                                             timeStampsReturned: 40,
                                             list: [],
                                             city: City(id: 2648579,
                                                        name: "Glasgow",
                                                        coord: Coord(lat: 55.8642, lon: -4.2518),
                                                        country: "GB",
                                                        population: 610268,
                                                        timezone: 0,
                                                        sunrise: 1645428509,
                                                        sunset: 1645464788))))
            }
        }
    }
}
