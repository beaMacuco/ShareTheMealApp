//
//  DataDecoderTests.swift
//  ShareTheMealAppTests
//
//

import XCTest
@testable import ShareTheMealApp

final class DataDecoderTests: XCTestCase {
    var sut: DataDecoder!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = DataDecoder()
    }

    func test_GivenDecodableData_WhenDecoded_ThenObjectIsReturned() throws {
        let codableMock = CodableMock.make()
        let expected = codableMock.id
        let data = try JSONEncoder().encode(codableMock)
        let mock: CodableMock = try sut.decode(from: data, dateFormatter: DateFormatter.yMDDateFormatter)
        
        XCTAssertEqual(expected, mock.id)
    }
    
    func test_GivenUnDecodableData_WhenDecoded_ThenErrorIsThrown() throws {
        let data = try JSONEncoder().encode("tandomString")
        do {
            _ = try sut.decode(from: data, dateFormatter: DateFormatter.yMDDateFormatter) as CodableMock
            XCTFail("Should have thrown decoding error")
        } catch {
            XCTAssertTrue(true)
        }
    }
}

