//
//  ImageLoader.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 28.07.25.
//

import SwiftUI

protocol ImageLoading {
    func fetchImage(from reference: String) async throws -> Image
}

class ImageLoader: ImageLoading {
    private let cache: ImageCaching
    private let imageRequest: ImageRequesting
    
    init(cache: ImageCaching = ImageCache(), imageRequest: ImageRequesting = ImageRequest()) {
        self.cache = cache
        self.imageRequest = imageRequest
    }
    
    func fetchImage(from reference: String) async throws -> Image {
        guard let uiImage = cache.fetch(reference: reference) else {
            return try await fetchRemoteImage(from: reference)
        }
        return Image(uiImage: uiImage)
    }
    
    private func fetchRemoteImage(from reference: String) async throws -> Image {
        let data = try await imageRequest.fetchImage(urlString: reference)
        guard let requestedImage = UIImage(data: data) else {
            throw NetworkError.dataCorrupted
        }
        cache.persist(image: requestedImage, by: reference)
        return Image(uiImage: requestedImage)
    }
}
