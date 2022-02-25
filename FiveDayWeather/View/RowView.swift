//
//  RowView.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 24/02/2022.
//

import SwiftUI
import Foundation

struct RowView: View {
    // MARK: - PROPERTIES
    private var weatherForecastItem: ForecastForParticularDayViewModel
    private var arrayOfTimeBasedForecasts: [ForecastForGivenDayAndTimeViewModel]
    
    init(weatherForecastItem: ForecastForParticularDayViewModel) {
        self.weatherForecastItem = ForecastForParticularDayViewModel(dayDateText: "", arrayOfTimeBasedForecasts: [])
        self.weatherForecastItem = weatherForecastItem
        self.arrayOfTimeBasedForecasts = weatherForecastItem.arrayOfTimeBasedForecasts
    }
    
    var body: some View {
        HStack {
            VStack {
                Text(weatherForecastItem.dayDateText).bold().multilineTextAlignment(.center)
            }
            
            ScrollView (.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(self.arrayOfTimeBasedForecasts, id: \.self) { forecast in
                        VStack {
                            Text(forecast.timeText).modifier(CellTextModifier())
                            AsyncImage(
                                url: URL(string: Constants.RemoteImages.imagesPath + forecast.iconString + Constants.RemoteImages.imagesSuffix)!,
                                placeholder: {  ProgressView() },
                                image: { Image(uiImage: $0).resizable() })
                                .frame(width: 35, height: 35, alignment: .center).padding(0)
                            Text(forecast.temperatureInCelciusString).modifier(CellTextModifier())
                            Text(forecast.conditions).modifier(CellTextModifier())
                        }.frame(width: 60)
                            .modifier(OutlineModifier())
                    }
                    Spacer().padding(5)
                } //: HStack
            } //: ScrollView
            .frame(height: 80)
            .padding()
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        // Here I grab some test date to allow the cell layout to be previewed
        let jsonData = Data.readLocalJsonFileInMainBundle(fileName: "TestWeather", extenstion: "json")
        let weatherData = try? JSONDecoder().decode(WeatherData.self, from: jsonData!)
        let someForecast = weatherData!.weatherForecastsList[1]
        let associatedViewModel = ForecastForGivenDayAndTimeViewModel(someForecast)
        let makeSeveralTheSame = [associatedViewModel, associatedViewModel, associatedViewModel, associatedViewModel, associatedViewModel, associatedViewModel]
        
        
        RowView(weatherForecastItem: ForecastForParticularDayViewModel(dayDateText: "Mon\n21 Feb",
                                                                       arrayOfTimeBasedForecasts: makeSeveralTheSame)).previewLayout(.sizeThatFits)
    }
}
