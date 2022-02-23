//
//  Constants.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 23/02/2022.
//

import Foundation

class Constants {
    
    struct API {
        static let apiKey = "53e60d29c7c5e2252dd959f3cfa42a28"
        static let defaultScheme = "https"
        static let defaultHost = "api.openweathermap.org"
        static let defaultPath = "/data/2.5/forecast"
    }
    
    struct RemoteImages {
        static let imagesPath = "https://openweathermap.org/img/wn/"
        static let imagesSuffix = ".png"
    }
}
