//
//  FileReaderMock.swift
//  ShareTheMealAppTests
//
//
import Foundation
@testable import ShareTheMealApp

enum ReaderMockResult {
    case fileExists, fileDoesNotExist
}

struct FileReaderMock: LocalFileReadable {
    let result: ReaderMockResult
    
    init(result: ReaderMockResult) {
        self.result = result
    }
    
    func readJsonFile() throws -> Data {
        switch result {
        case .fileDoesNotExist:
            throw(LocalFileReaderError.fileNotFound)
        case .fileExists:
            let mockData = CodableMock.make()
            let data = try JSONEncoder().encode(mockData)
            return data
        }
    }
}
