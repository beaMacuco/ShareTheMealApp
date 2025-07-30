//
//  DataDecoderTests.swift
//  ShareTheMealAppTests
//
//  Created by Beatriz Loures Macuco on 22.07.25.
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
        let mock: CodableMock = try sut.decode(from: data)
        
        XCTAssertEqual(expected, mock.id)
    }
    
    func test_GivenUnDecodableData_WhenDecoded_ThenObjectIsReturned() throws {
        let data = try JSONEncoder().encode("tandomString")
        do {
            _ = try sut.decode(from: data) as CodableMock
            XCTFail("Should have thrown decoding error")
        } catch {
            XCTAssertTrue(true)
        }
    }
}

