//
//  WeatherDataViewModel.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 21/02/2022.
//

import Combine
import Foundation

class WeatherDataViewModel: ObservableObject {
    
    private var weatherDataService: WeatherFetchingService
    
    var cancellable: AnyCancellable?
    
    var weatherDataHasBeenRequestedBefore: Bool = false
    
    @Published var cityName: String = ""
    @Published var weatherForecastsList: [ForecastForGivenDayAndTimeViewModel] = []
    @Published var forecastsForOneDay: [ForecastForParticularDayViewModel] = []
    
    @Published var requestSucceded: Bool = true
    
    // Inject the fetching service at creation of view model
    required init(weatherDataService: WeatherFetchingService) {
        self.weatherDataService = weatherDataService
    }
    
    func fetchWeatherData(lat: Double, long: Double) {
        
        self.weatherDataHasBeenRequestedBefore = true
        // Reset paremeters prior to reloading data
        cityName = ""
        weatherForecastsList = []
        forecastsForOneDay = []
        
        cancellable = weatherDataService.fetchFiveDayWeather(lat: lat, long: long).sink(receiveCompletion: { [weak self] completion in
            switch completion {
            case .finished:
                self?.requestSucceded = true
            case .failure(let error):
                print(error)
                self?.requestSucceded = false
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
