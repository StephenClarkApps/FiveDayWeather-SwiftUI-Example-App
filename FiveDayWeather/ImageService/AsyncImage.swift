//
//  AsyncImage.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 23/02/2022.
//

import Nuke
import SwiftUI

struct AsyncImage<Placeholder: View>: View {
    let url: URL
    private let placeholder: Placeholder
    @State private var uiImage: UIImage? = nil

    init(url: URL, @ViewBuilder placeholder: () -> Placeholder) {
        self.placeholder = placeholder()
        self.url = url
    }

    var body: some View {
        ZStack {
            if let image = uiImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            } else {
                placeholder
            }
        }
        .onAppear { load(url) }
        .onChange(of: url) { load($0) }
    }

    private func load(_ url: URL) {
        ImagePipeline.shared.loadImage(with: url) { result in
            if case let .success(response) = result {
                DispatchQueue.main.async {
                    self.uiImage = response.image
                }
            }
        }
    }
}
