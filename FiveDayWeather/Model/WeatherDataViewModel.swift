//
//  WeatherDataViewModel.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 21/02/2022.
//

import Combine
import Foundation

class WeatherDataViewModel: ObservableObject {
    
    private let weatherDataService = WeatherDataService()
    
    var cancellable: AnyCancellable?

    @Published var cityName: String = ""
    
    @Published var weatherForecastsList: [ForecastForGivenDayAndTimeViewModel] = []
    
    func featchWeatherData() {
        cancellable = weatherDataService.fetchFiveDayWeather().sink(receiveCompletion: { _ in
            
        }, receiveValue: { [weak self] weatherContainer in
            guard let strongSelf = self else { return }
            strongSelf.cityName = weatherContainer.city.name
            strongSelf.weatherForecastsList = weatherContainer.weatherForecastsList.map { ForecastForGivenDayAndTimeViewModel($0) }
        })
    }
}

struct ForecastForGivenDayAndTimeViewModel: Codable, Hashable {

    private let forecastForGivenDayAndTime: ForecastForGivenDayAndTime
    
    var dtTxt: String {
        return forecastForGivenDayAndTime.dtTxt
    }
    
    var conditions: String {
        // in the case of our json, the weather array always has just one item with id, main, description, icon as parameters
        return forecastForGivenDayAndTime.weather.first?.main.rawValue ?? ""
    }
    
    var conditionsDescription: String {
        // in the case of our json, the weather array always has just one item with id, main, description, icon as parameters
        return forecastForGivenDayAndTime.weather.first?.weatherDescription ?? ""
    }
    
    // A string corresponsing with the icon which is suggested to be used to depict the conditions
    var iconString: String {
        return forecastForGivenDayAndTime.weather.first?.icon ?? ""
    }
    
    init(_ forecastForGivenDayAndTime: ForecastForGivenDayAndTime) {
        self.forecastForGivenDayAndTime = forecastForGivenDayAndTime
    }
}

// Because our view is going to be list of horizontally scrollable element with one
// row for each day, we'll need a view model that combines the hours for each day,
// into something that's ready to be displayed in rows.
struct ForecastForParticularDayViewModel: Codable, Hashable {
    
}
