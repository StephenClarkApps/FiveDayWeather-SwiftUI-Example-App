//
//  DateExtensionTests.swift
//  FiveDayWeatherTests
//
//  Created by Stephen Clark on 25/02/2022.
//

import XCTest

@testable import FiveDayWeather

class DateExtensionTests: XCTestCase {
    
    // Test cellLabelStyleDateString
    func test_cellLabelStyleDateString_worksCorrectly() {
        // GIVEN
        let date = Date(timeIntervalSince1970: 1645747679)
        // WHEN
        let cellDateString = date.cellLabelStyleDateString()
        // THEN
        XCTAssertEqual(cellDateString, "Fri\n25 Feb")
    }
    
    
    // Test simpleHourTimeText
    func test_simpleHourTimeText_formatsCorrectly() {
        // GIVEN
        let date = Date(timeIntervalSince1970: 1645747679)
        // WHEN
        let simpleHourTimeText = date.simpleHourTimeText()
        // THEN
        XCTAssertEqual(simpleHourTimeText, "12 AM")
    }
    
    func test_DateFromUnixTimeStampInteger_worksCorrectly() {
        // GIVEN
        let integerValue = 1645747679
        // WHEN
        let date = Date(unixTimestampInt: integerValue)
        // THEN
        let theIntevalDouble = date.timeIntervalSince1970
        let asAnIntThis = Int(theIntevalDouble)
        XCTAssertEqual(asAnIntThis, 1645747679)
    }
}
