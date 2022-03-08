//
//  AsyncImage.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 23/02/2022.
//

import SwiftUI
import Nuke
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

/*
 struct AsyncImage<Placeholder: View>: View {
     
     // MARK: - Properties
     @StateObject private var loader: ImageLoader
     private let placeholder: Placeholder
     private let image: (UIImage) -> Image
     
     // MARK: - Init, Body and Content
     init(url: URL, @ViewBuilder placeholder: () -> Placeholder, @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)) {
         
         self.placeholder = placeholder()
         self.image = image
         _loader = StateObject(wrappedValue: ImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
     }
     
     var body: some View {
         content
             .onAppear(perform: loader.load)
     }
     
     private var content: some View {
         Group {
             if loader.image != nil {
                 image(loader.image!)
             } else {
                 placeholder
             }
         }
     }
 }
 */
