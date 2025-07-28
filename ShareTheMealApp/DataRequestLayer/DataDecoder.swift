//
//  DataDecoder.swift
//  ShareTheMealApp
//
//  Created by Beatriz Loures Macuco on 22.07.25.
//

import Foundation

enum DecodableError: Error {
    case decodingError
}

protocol DataDecodable {
    func decode<T: Codable>(from data: Data) throws -> T
}

struct DataDecoder: DataDecodable {
    
    func decode<T: Codable>(from data: Data) throws -> T {
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        var decodeResponse: T

        do {
            decodeResponse = try decoder.decode(T.self, from: data)
        } catch {
            // should log instead of printing
            print(error)
            throw DecodableError.decodingError
        }
        
        return decodeResponse
    }
}
