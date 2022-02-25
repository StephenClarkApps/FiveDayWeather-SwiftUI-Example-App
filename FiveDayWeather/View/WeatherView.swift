//
//  WeatherView.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 21/02/2022.
//

import SwiftUI

struct WeatherView: View {
    
    // MARK: - PROPERTIES
    
    @ObservedObject var model: WeatherDataViewModel = WeatherDataViewModel(weatherDataService: WeatherDataService())
    @ObservedObject var locationManager = LocationManager()
    
    // Alert related objects
    @State var showAlert: Bool = false
    @State var alertText: String = ""
    @State var alertDescription: String = ""
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
                List(self.model.forecastsForOneDay, id: \.self) { weatherForecastItem in
                    ZStack {
                        RowView(weatherForecastItem: weatherForecastItem)
                            HStack {
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .frame(width: 10, height: 65, alignment: .center)
                                    .foregroundColor(.gray)
                                    .background(.white)
                            } //: HStack
                            .opacity((weatherForecastItem.arrayOfTimeBasedForecasts.count > 3) && (UIDevice.current.userInterfaceIdiom == .phone) ? 1.0 : 0.0)
                        
                    } //: ZStack
                } //: List
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(alertText),
                        message: Text(alertDescription),
                        dismissButton: .default(Text("OK")))
                }
                .navigationBarTitle(Text(model.cityName))
                .refreshable {
                    if !(locationManager.statusString == "authorizedWhenInUse"
                         || locationManager.statusString == "authorizedAlways"
                         || locationManager.statusString == "notDetermined") {
                        
                        alertText = "Invalid Location Status"
                        alertDescription = "This app needs location to be enabled.\nDo this in the phones settings for this app."
                        showAlert.toggle()
                    } else {
                        model.fetchWeatherData(lat: self.locationManager.lastLocation?.coordinate.latitude ?? 0.0,
                                                long: self.locationManager.lastLocation?.coordinate.longitude ?? 0.0)
                    }
                }
                .onChange(of: locationManager.lastLocation) { loc in
                    
                    // If we haven't already got results and the location changes, then load the data
                    if (locationManager.statusString == "authorizedWhenInUse" || locationManager.statusString == "authorizedAlways")
                        && !(self.model.weatherDataHasBeenRequestedBefore) {
                        model.fetchWeatherData(lat: loc?.coordinate.latitude ?? 0.0,
                                                long: loc?.coordinate.longitude ?? 0.0)
                    }
                }
                .onChange(of: locationManager.statusString) { newValue in
                    // Let the user know if they need to change locaiton settings
                    if !(newValue == "authorizedWhenInUse" || newValue == "authorizedAlways" || newValue == "notDetermined") {
                        alertText = "Invalid Location Status"
                        alertDescription = "This app needs location to be enabled. Do this in the phones settings for this app."
                        showAlert.toggle()
                    }
                }
                .onChange(of: model.requestSucceded) { newValue in
                    if newValue == false {
                        alertText = "Issue Getting Data From Server"
                        alertDescription = "Check connection and swipe down to try again."
                        showAlert.toggle()
                    }
                }
        } // :Navigation View
        .navigationViewStyle(.stack)
        
    }
}

// MARK: - PREVIEWß
struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
