//
//  LocalJsonReaderTests.swift
//  ShareTheMealAppTests
//
//  Created by Beatriz Loures Macuco on 23.07.25.
//

import XCTest
@testable import ShareTheMealApp

final class LocalJsonReaderTests: XCTestCase {
    var sut: LocalJsonReader!
    
    func test_GivenFileExists_WhenFetchItems_ThenDataFetchedCorrectly() async throws {
        let dataDecoder = DataDecoder()
        let fileReaderMock = FileReaderMock(result: .fileExists)
        sut = LocalJsonReader(dataDecoder: dataDecoder, localFileReader: fileReaderMock)
        let expected = CodableMock.make()
        
        guard let mock: CodableMock = try sut.fetchItems() else {
            XCTFail("Could not decode mock")
            return
        }
        XCTAssertEqual(mock.id, expected.id)
    }
    
    func test_GivenFileDoesNotExist_WhenFetchItems_ThenErrorThrown() throws {
        let dataDecoder = DataDecoder()
        let fileReaderMock = FileReaderMock(result: .fileDoesNotExist)
        sut = LocalJsonReader(dataDecoder: dataDecoder, localFileReader: fileReaderMock)

        do {
            _ = try sut.fetchItems() as CodableMock?
            XCTFail("Should have thrown file not found erro")
        } catch {
            XCTAssertTrue(true)
        }
    }
}
