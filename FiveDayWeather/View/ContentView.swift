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
        let appearance = UITabBar.appearance()
        
        appearance.isOpaque = true
        appearance.tintColor = UIColor.white
        appearance.barTintColor = UIColor.systemBackground
        appearance.backgroundColor = UIColor.systemBackground
        
        // Code extends bar color under top data / time area
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes =  [.foregroundColor: UIColor.white,
                                               NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 10)]
            appearance.backgroundColor = UIColor.systemBackground
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            
        }
        
        appearance.barStyle = .black
        appearance.isTranslucent = false
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
        }//.background(.gray)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView() //.environmentObject(Order())
    }
}
