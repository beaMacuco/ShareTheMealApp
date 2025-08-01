//
//  LocalJsonReader.swift
//  ShareTheMealApp
//
//

import Foundation
    

protocol DataRequestable {
    func fetchItems<T: Codable>() throws -> T
}

struct LocalJsonReader: DataRequestable {
    private static let jsonFileType: String = "json"
    private static let mockFile: String = "campaigns_mock"
    private let dataDecoder: DataDecodable
    private let localFileReader: LocalFileReadable
    
    init(dataDecoder: DataDecodable = DataDecoder(),
         localFileReader: LocalFileReadable = LocalFileReader(fileName: Self.mockFile, fileType: Self.jsonFileType)) {
        self.dataDecoder = dataDecoder
        self.localFileReader = localFileReader
    }
    
    func fetchItems<T: Codable>() throws -> T {
        let data = try readJsonFile()
        return try dataDecoder.decode(from: data)
    }
    
    private func readJsonFile() throws -> Data {
        try localFileReader.readJsonFile()
    }
}

