//
//  MapView.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 23/02/2022.
//

import MapKit
import SwiftUI


struct MapView: View {
    
    // Region should update to match users location, when location is enabled
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
                                                   span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}