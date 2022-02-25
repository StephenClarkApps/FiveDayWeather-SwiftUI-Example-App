//
//  ImageCache.swift
//  FiveDayWeather
//
//  Created by Stephen Clark on 23/02/2022.
//

import UIKit

protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}

struct TemporaryImageCache: ImageCache {
    
    // Using NSCache can still be a good option when we are not using a caching framework
    
    private let cache: NSCache<NSURL, UIImage> = {
        let cache = NSCache<NSURL, UIImage>()
        cache.countLimit = 100                    // Maximum number of items to retain
        cache.totalCostLimit = 1024 * 1024 * 120  // Size constraint 120 MB
        return cache
    }()
    
    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}
