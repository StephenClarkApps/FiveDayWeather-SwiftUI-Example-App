//
//  Date+FDW.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 24/02/2022.
//

import Foundation

public extension Date {
    
    /// Cell Label style date string from date.
    ///
    /// - Returns: date string.
    func cellLabelStyleDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateFormat = "E\nd MMM"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
    
    
    /// Function to get a simple time string
    ///
    /// - Returns: time string from date in format "9 AM" / "10 PM"
    func simpleHourTimeText() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
    
    /// Create new date object from UNIX timestamp, provided as an Int.
    ///
    ///     let date = Date(unixTimestampInt: 1645747679) // "Feb 25, 2022, 12:07AM"
    ///
    /// - Parameter unixTimestamp: UNIX timestamp.
    init(unixTimestampInt: Int) {
        self.init(timeIntervalSince1970: Double(unixTimestampInt))
    }
}
