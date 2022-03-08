//
//  AsyncImage.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 23/02/2022.
//

import Nuke
import SwiftUI
import FetchImage

struct AsyncImage<Placeholder: View>: View {
    
    let url: URL
    
    private let placeholder: Placeholder
    
    @StateObject private var image = FetchImage()
    
    init(url: URL, @ViewBuilder placeholder: () -> Placeholder) {
        
        self.placeholder = placeholder()
        self.url = url
    }
    
    var body: some View {
        
        ZStack {
            if (image.view != nil) {
                image.view?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            } else {
                placeholder
            }
        }
        .onAppear { image.load(url) }
        .onChange(of: url) { image.load($0) }
        .onDisappear(perform: image.reset)
    }
}
