//
//  FiveDayWeatherTests.swift
//  FiveDayWeatherTests
//
//  Created by Stephen Clark on 21/02/2022.
//

import XCTest
import Combine

@testable import FiveDayWeather

class FiveDayWeatherTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Networking and API
    
    func testGettingWeatherFromAPI() throws {

        let expectation = XCTestExpectation(description: "Get weather data from test api call")
        let observer: AnyCancellable?
        var weatherDataService: WeatherFetchingService = WeatherDataService()
        
        observer = weatherDataService.fetchFiveDayWeather(lat: 55.8642, long: -4.2518).sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("Success")
                expectation.fulfill()
            case .failure(let error):
                print(error)
            }
        }, receiveValue: { weatherContainer in

        })

        
        wait(for: [expectation], timeout: 10.0)
    }
    
    // MARK: - Decoding Data

    func test_DecodingRootCodableObjectFromJson() throws {

        // GIVEN
        guard let jsonData = readLocalFile(forName: "TestWeather") else { XCTFail("Can't read local json file"); return }
        // WHEN
        let weatherData = try? JSONDecoder().decode(WeatherData.self, from: jsonData)
        // THEN
        XCTAssertTrue(weatherData?.city.name == "Glasgow")
        XCTAssertTrue(weatherData?.timeStampsReturned == 40)
        XCTAssertTrue(weatherData?.weatherForecastsList[1].sys.partOfDay == .night)
        XCTAssertTrue(weatherData?.weatherForecastsList[0].main.temp == 9.07)
         
    }
    
    func testForecastForGivenDayAndTimeViewModel() throws {
        // Given
        guard let jsonData = readLocalFile(forName: "TestWeather") else { XCTFail("Can't read local json file"); return }
        let weatherData = try? JSONDecoder().decode(WeatherData.self, from: jsonData)
        let someForecast = weatherData?.weatherForecastsList[1] // giving a ForecastForGivenDayAndTime
        
        // When
        let associatedViewModel = ForecastForGivenDayAndTimeViewModel(someForecast!)
        
        // Then
        XCTAssertTrue(associatedViewModel.dateText == "Mon\n21 Feb")
        XCTAssertTrue(associatedViewModel.timeText == "6 PM")
        XCTAssertTrue(associatedViewModel.iconString == "02n")
       
    }
    
    // MARK: - Helper Functions
    
    func readLocalFile(forName name: String) -> Data? {
        do { // Bundle(for: type(of: self))
            if let bundlePath = Bundle(for: type(of: self )).path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}
