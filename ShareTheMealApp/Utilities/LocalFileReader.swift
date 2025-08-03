//
//  LocalFileReader.swift
//  ShareTheMealApp
//
//

import Foundation

enum LocalFileReaderError: Error {
    case fileNotFound
}

protocol LocalFileReadable {
    func readJsonFile() throws -> Data
}

struct LocalFileReader: LocalFileReadable {
    let fileName: String
    let fileType: String
    
    /// Reads local json file throws error if not found
    func readJsonFile() throws -> Data {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: fileType) else {
            throw LocalFileReaderError.fileNotFound
        }
        let fileUrl = URL(fileURLWithPath: filePath)
        return try Data(contentsOf: fileUrl)
    }
}
