//
//  ForecastForGivenDayTimeViewModel.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 24/02/2022.
//

import Foundation

struct ForecastForGivenDayAndTimeViewModel: Codable, Hashable {
    
    private let forecastForGivenDayAndTime: ForecastForGivenDayAndTime
    
    init(_ forecastForGivenDayAndTime: ForecastForGivenDayAndTime) {
        self.forecastForGivenDayAndTime = forecastForGivenDayAndTime
    }
    
    var dtTxt: String {
        return forecastForGivenDayAndTime.dtTxt
    }
    
    // We're interested in displaying results in a horizontal scroll view which come from
    // the same day of the week so we can group results by this parameter.
    var dateText: String {
        let date = Date(unixTimestampInt: forecastForGivenDayAndTime.dt)
        return date.cellLabelStyleDateString()
    }
    
    /// Return a time text such as 9 AM, 9 PM for a given hourly forecast
    var timeText: String {
        let date = Date(unixTimestampInt: forecastForGivenDayAndTime.dt)
        return date.simpleHourTimeText()
    }
    
    // in the case of our json, the weather array always has just one item with id, main, description, icon as parameters
    var conditions: String {
        return forecastForGivenDayAndTime.weather.first?.main.rawValue ?? ""
    }
    
    // Description of the weather conditions
    var conditionsDescription: String {
        return forecastForGivenDayAndTime.weather.first?.weatherDescription ?? ""
    }
    
    // A string corresponsing with the icon which is suggested to be used to depict the conditions
    var iconString: String {
        return forecastForGivenDayAndTime.weather.first?.icon ?? ""
    }
    
    var temperatureInCelciusString: String {
        return String(Int(forecastForGivenDayAndTime.main.temp.rounded())) + " ℃"
    }
}
