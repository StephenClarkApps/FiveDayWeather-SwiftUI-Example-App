//
//  ContentView.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 21/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var model: WeatherDataViewModel = WeatherDataViewModel()
    
    var body: some View {
        NavigationView {
            List(model.weatherForecastsList, id: \.self) { weatherForecastItem in
                
                
                ScrollView (.horizontal, showsIndicators: false) {
                    HStack {
                        //contents
                        Image(systemName: "heart.fill")
                        Text(weatherForecastItem.dtTxt)
                        Text(weatherForecastItem.conditions)
                        Text(weatherForecastItem.conditionsDescription)

                    }
                }.frame(height: 55)
            }
            .navigationBarTitle(Text(model.cityName))
            .onAppear {
                model.featchWeatherData()
            }


        } // :Navigation View
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
