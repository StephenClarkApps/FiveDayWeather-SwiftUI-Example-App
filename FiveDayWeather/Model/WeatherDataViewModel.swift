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
    
    var weatherDataHasBeenRequestedBefore: Bool = false
    
    @Published var cityName: String = ""
    @Published var weatherForecastsList: [ForecastForGivenDayAndTimeViewModel] = []
    @Published var forecastsForOneDay: [ForecastForParticularDayViewModel] = []
    
    func featchWeatherData(lat: Double, long: Double) {
        
        self.weatherDataHasBeenRequestedBefore = true
        // Reset paremeters prior to reloading data
        cityName = ""
        weatherForecastsList = []
        forecastsForOneDay = []
        
        cancellable = weatherDataService.fetchFiveDayWeather(lat: lat, long: long).sink(receiveCompletion: { [weak self] completion in
            switch completion {
            case .finished:
                print("Successfully got data.")
                
            case .failure(let error):
                print(error)
            }
        }, receiveValue: { [weak self] weatherContainer in
            guard let strongSelf = self else { return }
            strongSelf.cityName = weatherContainer.city.name
            strongSelf.weatherForecastsList = weatherContainer.weatherForecastsList.map { ForecastForGivenDayAndTimeViewModel($0) }
            
            // I'll use these "temporary" parameters to covert to a day based model
            var temporaryDateString = ""
            var temporaryForecastForParticularDayViewModel =  ForecastForParticularDayViewModel(dayDateText: "", arrayOfTimeBasedForecasts: [])
            
            strongSelf.weatherForecastsList.forEach { hourForecast in
                if hourForecast.dateText == temporaryDateString {    // Match - means we build up our list for a given day by adding additional ForecastForParticularDayViewModel
                    temporaryForecastForParticularDayViewModel.arrayOfTimeBasedForecasts.append(hourForecast)
                    
                } else {
                    // 1. First save a given day to our forecasts array (unless day text is blank)
                    if temporaryForecastForParticularDayViewModel.dayDateText == "" {
                        temporaryDateString = hourForecast.dateText
                        temporaryForecastForParticularDayViewModel.dayDateText = temporaryDateString // SET ONCE PER CASE
                        temporaryForecastForParticularDayViewModel.arrayOfTimeBasedForecasts.append(hourForecast)
                    } else {
                        strongSelf.forecastsForOneDay.append(temporaryForecastForParticularDayViewModel) // SAVE
                        temporaryForecastForParticularDayViewModel =  ForecastForParticularDayViewModel(dayDateText: "", arrayOfTimeBasedForecasts: []) // RESET TEMP STORE
                        // Add initial record
                        temporaryDateString = hourForecast.dateText
                        temporaryForecastForParticularDayViewModel.dayDateText = temporaryDateString
                        temporaryForecastForParticularDayViewModel.arrayOfTimeBasedForecasts.append(hourForecast)
                    }
                }
            }
            
        })
    }
}

struct ForecastForGivenDayAndTimeViewModel: Codable, Hashable {
    
    private let forecastForGivenDayAndTime: ForecastForGivenDayAndTime
    
    var dtTxt: String {
        return forecastForGivenDayAndTime.dtTxt
    }
    
    // We're interested in displaying results in a horizontal scroll view which come from
    // the same day of the week so we can group results by this parameter.
    var dateText: String {
        
        let date = Date(timeIntervalSince1970: Double(forecastForGivenDayAndTime.dt))
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none //Set time style
        dateFormatter.dateFormat = "E\nd MMM"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
    
    /// Return a time text such as 9 AM, 9 PM for a given hourly forecast
    var timeText: String {
        let date = Date(timeIntervalSince1970: Double(forecastForGivenDayAndTime.dt))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
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
    
    var temperatureInCelciusString: String {
        return String(Int(forecastForGivenDayAndTime.main.temp.rounded())) + " ℃"
    }
    
    init(_ forecastForGivenDayAndTime: ForecastForGivenDayAndTime) {
        self.forecastForGivenDayAndTime = forecastForGivenDayAndTime
    }
}

// Because our view is going to be list of horizontally scrollable element with one
// row for each day, we'll need a view model that combines the hours for each day,
// into something that's ready to be displayed in rows.
struct ForecastForParticularDayViewModel: Codable, Hashable {
    
    var uuid: UUID
    var dayDateText: String = "" // i.e. "Wed\n23rd Feb"
    var arrayOfTimeBasedForecasts: [ForecastForGivenDayAndTimeViewModel]
    
    init(dayDateText: String, arrayOfTimeBasedForecasts: [ForecastForGivenDayAndTimeViewModel]) {
        self.uuid = UUID() // Helps with default hashable in this case
        self.dayDateText = dayDateText
        self.arrayOfTimeBasedForecasts = arrayOfTimeBasedForecasts
    }
    
}
