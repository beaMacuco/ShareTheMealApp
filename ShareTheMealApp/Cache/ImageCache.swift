//
//  ImageCache.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 28.07.25.
//

import UIKit

protocol ImageCaching {
    func fetch(reference: String) -> UIImage?
    func persist(image: UIImage, by reference: String)
}

final class ImageCache: ImageCaching {
    private let cache: NSCache<NSString, UIImage>
    
    init(cache: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()) {
        self.cache = cache
    }
    
    func fetch(reference: String) -> UIImage? {
        cache.object(forKey: (reference as NSString))
    }
    
    func persist(image: UIImage, by reference: String) {
        cache.setObject(image, forKey: (reference as NSString))
    }
}
