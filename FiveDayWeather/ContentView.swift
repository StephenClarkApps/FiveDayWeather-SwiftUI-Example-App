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

        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
