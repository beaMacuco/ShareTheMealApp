//
//  ImageRequest.swift
//  ShareTheMealApp
//
//

import SwiftUI

enum NetworkError: Error, Equatable {
    case malformedUrl
    case invalidResponse
    case httpResponseError(Int)
    case decodingError
    case dataCorrupted
}

protocol ImageRequesting {
    func fetchImage(urlString: String) async throws -> Data
}

final class ImageRequest: ImageRequesting {
    private let successStatusCodeRange = 200..<300
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchImage(urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw NetworkError.malformedUrl
        }
        let (data, response) = try await urlSession.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard successStatusCodeRange.contains(httpResponse.statusCode) else {
            throw NetworkError.httpResponseError(httpResponse.statusCode)
        }
        
        return data
    }
}


