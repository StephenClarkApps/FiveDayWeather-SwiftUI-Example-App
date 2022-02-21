//
//  WeatherDataViewModel.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 21/02/2022.
//

import Foundation

class WeatherDataViewModel {
    
    func testParseWeatherData() {
        
        guard let jsonData = readLocalFile(forName: "TestWeather") else { return }
        let weatherData = try? JSONDecoder().decode(WeatherData.self, from: jsonData)
        print (weatherData!.city.name)
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}
