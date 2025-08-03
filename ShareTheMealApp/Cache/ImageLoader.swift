//
//  ImageLoader.swift
//  ShareTheMealApp
//
//

import SwiftUI

protocol ImageLoading {
    func fetchImage(from reference: String) async -> Image?
}

final class ImageLoader: ImageLoading {
    private let cache: ImageCaching
    private let imageRequest: ImageRequesting
    
    init(cache: ImageCaching = ImageCache(), imageRequest: ImageRequesting = ImageRequest()) {
        self.cache = cache
        self.imageRequest = imageRequest
    }
    
    /// Try to fetch image from cache before fetching it from remote
    func fetchImage(from reference: String) async -> Image? {
        guard let uiImage = cache.fetch(reference: reference) else {
            return await fetchRemoteImage(from: reference)
        }
        return Image(uiImage: uiImage)
    }
    
    /// Fetches images from remote and caches them locally.
    private func fetchRemoteImage(from reference: String) async -> Image? {
        var image: Image?
        do {
            let data = try await imageRequest.fetchImage(urlString: reference)
            guard let requestedImage = UIImage(data: data) else {
                throw NetworkError.dataCorrupted
            }
            cache.persist(image: requestedImage, by: reference)
            image = Image(uiImage: requestedImage)
            
        } catch {
            // In the case of an image request failure there is not much to show to the user so we just log this to see if there is a fix and continue presenting a placeholder to the user.
            print(error)
        }
        return image
    }
}
