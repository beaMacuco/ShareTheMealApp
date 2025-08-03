//
//  DataDecoder.swift
//  ShareTheMealApp
//
//

import Foundation

enum DecodableError: Error {
    case decodingError
}

protocol DataDecodable {
    func decode<T: Codable>(from data: Data, dateFormatter: DateFormatter) throws -> T
}

struct DataDecoder: DataDecodable {
    
    /// A generic data decoder for codable objects that formats the date.
    func decode<T: Codable>(from data: Data, dateFormatter: DateFormatter) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
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
