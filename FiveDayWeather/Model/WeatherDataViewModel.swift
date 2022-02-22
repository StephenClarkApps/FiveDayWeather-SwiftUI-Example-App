//
//  WeatherDataViewModel.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 21/02/2022.
//

import Foundation

class WeatherDataViewModel: ObservableObject {

    @Published var cityName: String = ""
    @Published var weatherForecastsList: [ForecastForGivenDayAndTime] = []
    
}
