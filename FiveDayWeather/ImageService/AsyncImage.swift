//
//  AsyncImage.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 23/02/2022.
//

import SwiftUI
import Nuke
import FetchImage

struct ImageView: View {
    let url: URL

    @StateObject private var image = FetchImage()

    var body: some View {
        ZStack {
           // Rectangle().fill(Color.gray)
            image.view?
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
        }
        .onAppear { image.load(url) }
        .onChange(of: url) { image.load($0) }
        .onDisappear(perform: image.reset)
    }
}
