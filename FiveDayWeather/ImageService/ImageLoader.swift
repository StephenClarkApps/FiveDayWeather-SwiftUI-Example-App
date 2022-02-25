//
//  ImageLoader.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 23/02/2022.
//

import Combine
import UIKit

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private(set) var imageIsLoading = false
    
    private let url: URL
    private var imageCache: ImageCache?
    private var cancellable: AnyCancellable?
    
    private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
    
    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.imageCache = cache
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        guard !imageIsLoading else { return }

        // If we already have an image stored in our image cache for a particular URL
        // then we get the image from there instead of requesting it again.
        if let image = imageCache?[url] {
            self.image = image
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.imageHasStartedLoading()
            },
                          receiveOutput: { [weak self] in
                self?.cache($0)
            },
                          receiveCompletion: { [weak self] _ in
                self?.imageHasFinishedLoading()
            },
                          receiveCancel: { [weak self] in
                self?.imageHasFinishedLoading()
            })
            .subscribe(on: Self.imageProcessingQueue)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.image = $0
            }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
    private func imageHasStartedLoading() {
        imageIsLoading = true
    }
    
    private func imageHasFinishedLoading() {
        imageIsLoading = false
    }
    
    private func cache(_ image: UIImage?) {
        image.map { imageCache?[url] = $0 }
    }
}
