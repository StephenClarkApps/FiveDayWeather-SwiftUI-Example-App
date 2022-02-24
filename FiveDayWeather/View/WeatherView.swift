//
//  WeatherView.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 21/02/2022.
//

import SwiftUI

struct WeatherView: View {
    
    @ObservedObject var model: WeatherDataViewModel = WeatherDataViewModel()
    @ObservedObject var locationManager = LocationManager()
        
    var body: some View {
        NavigationView {
                List(self.model.forecastsForOneDay, id: \.self) { weatherForecastItem in
                    ZStack {
                        HStack { // TODO: SEPERATE OUT CELL
                            VStack {
                                Text(weatherForecastItem.dayDateText).bold().multilineTextAlignment(.center)
                            }
                            
                            ScrollView (.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(weatherForecastItem.arrayOfTimeBasedForecasts, id: \.self) { forecast in
                                        VStack {
                                            Text(forecast.timeText).font(Font(UIFont.systemFont(ofSize: 12.0))).bold()
                                            AsyncImage(
                                                url: URL(string: Constants.RemoteImages.imagesPath + forecast.iconString + Constants.RemoteImages.imagesSuffix)!,
                                                placeholder: {  ProgressView() },
                                                image: { Image(uiImage: $0).resizable() })
                                                .frame(width: 35, height: 35, alignment: .center).padding(0)
                                            Text(forecast.temperatureInCelciusString).font(Font(UIFont.systemFont(ofSize: 12.0))).bold()
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
                        
                        if (weatherForecastItem.arrayOfTimeBasedForecasts.count > 3) && (UIDevice.current.userInterfaceIdiom == .phone) {
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
                .refreshable {
                    // Loading
                    model.featchWeatherData(lat: self.locationManager.lastLocation?.coordinate.latitude ?? 0.0,
                                            long: self.locationManager.lastLocation?.coordinate.longitude ?? 0.0)
                }
                .onChange(of: locationManager.lastLocation) { loc in
                    
                    // If we haven't already got results and the location changes, then load the data
                    if (locationManager.statusString == "authorizedWhenInUse" || locationManager.statusString == "authorizedAlways")
                        && !(self.model.weatherDataHasBeenRequestedBefore) {
                        model.featchWeatherData(lat: loc?.coordinate.latitude ?? 0.0,
                                                long: loc?.coordinate.longitude ?? 0.0)
                    } else {
                        print("Location status unsupported")
                    }
                    
            }
            
        } // :Navigation View
        .navigationViewStyle(.stack)
        
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
