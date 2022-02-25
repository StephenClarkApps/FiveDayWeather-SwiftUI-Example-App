//
//  ForecastForParticularDayViewModel.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 24/02/2022.
//

import Foundation

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
