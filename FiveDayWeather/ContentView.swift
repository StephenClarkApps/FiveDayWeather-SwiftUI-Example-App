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
            
            // Each row should clearly show date, and each cell
            // within the row should clearly show the temperature
            // and the time of the day.
            
            List(self.model.forecastsForOneDay, id: \.self) { weatherForecastItem in
                ZStack {
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack {
                            // DATE
                            VStack {
                                Text(weatherForecastItem.dayDateText).bold().multilineTextAlignment(.center)
                            }
                            
                            Spacer()
                            
                            ForEach(weatherForecastItem.arrayOfTimeBasedForecasts, id: \.self) { forecast in
                                VStack {
                                    Text(forecast.timeText).font(Font(UIFont.systemFont(ofSize: 10.0)))
                                    Image(systemName: "cloud.rain")
                                    Text(forecast.conditions).font(Font(UIFont.systemFont(ofSize: 10.0)))
                                }.frame(width: 50)
                                .padding(5)
                                .border(.gray)
                            }
                            
                            Spacer().padding(4)
                            
                        } //: HStack
                    } //: ScrollView
                    .frame(height: 65)
                    
                    HStack {
                        Spacer()
                        Image(systemName: "chevron.right")
                            .frame(width: 10, height: 65, alignment: .center)
                            .foregroundColor(.gray)
                            .background(.white)
                    } //: HStack
                    
                } //: ZStack
            } //: List
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
