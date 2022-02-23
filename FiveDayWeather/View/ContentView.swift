//
//  XContentView.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 23/02/2022.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    init() {
        FDAppearance.setUpApperance()
    }

    var body: some View {
        TabView {
            WeatherView()
                .tabItem {
                    Image("icnStorm").renderingMode(.template)
                    Text("Weather")
                }
                .tag(1)
            
            MapView()
                .tabItem {
                    Image("icnMap").renderingMode(.template)
                    Text("Map")
                }
                .tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
