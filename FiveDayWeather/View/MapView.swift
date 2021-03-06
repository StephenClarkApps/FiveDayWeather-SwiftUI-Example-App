//
//  MapView.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 23/02/2022.
//

import MapKit
import SwiftUI


struct MapView: View {
    
    // MARK: - PROPERTIES
    // Region should update to match users location (due to our use of tracking mode below), when location is enabled
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
                                                   span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            VStack {
                Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow)).frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            }.navigationBarTitle(Text("Map"))
        }.navigationViewStyle(.stack)
    }
}

// MARK: - PREVIEW
struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
