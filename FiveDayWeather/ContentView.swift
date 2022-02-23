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
                    HStack {
                        VStack {
                            Text(weatherForecastItem.dayDateText).bold().multilineTextAlignment(.center)
                        }
                        
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(weatherForecastItem.arrayOfTimeBasedForecasts, id: \.self) { forecast in
                                    VStack {
                                        Text(forecast.timeText).font(Font(UIFont.systemFont(ofSize: 12.0))).bold()
                                        AsyncImage(
                                            url: URL(string:"https://openweathermap.org/img/wn/" + forecast.iconString + ".png")!,
                                            placeholder: { Image(systemName: "hourglass.tophalf.filled") },
                                            image: { Image(uiImage: $0).resizable() })
                                            .frame(width: 35, height: 35, alignment: .center).padding(0)
                                        Text(forecast.conditions).font(Font(UIFont.systemFont(ofSize: 12.0))).bold()
                                    }.frame(width: 60)
                                        .padding(4)
                                        .border(.gray, width: 0.5)
                                }
                                
                                Spacer().padding(5)
                            } //: HStack
                        } //: ScrollView
                        .frame(height: 80)
                        .padding()
                        
                    } //: HStack
                    
                    if weatherForecastItem.arrayOfTimeBasedForecasts.count > 3 {
                        HStack {
                            Spacer()
                            Image(systemName: "chevron.right")
                                .frame(width: 10, height: 65, alignment: .center)
                                .foregroundColor(.gray)
                                .background(.white)
                        } //: HStack
                    } //: if
                    
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
