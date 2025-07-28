//
//  MealProgramRequestTests.swift
//  ShareTheMealAppTests
//
//  Created by Beatriz Loures Macuco on 23.07.25.
//

import XCTest
@testable import ShareTheMealApp

final class MealProgramRequestTests: XCTestCase {

    func test_GivenItemsToFetch_WhenFetched_ThenListOfItemsReturned() async throws {
        let dataRetrievableMock = DataRequestableMock()
        let sut = MealProgramRequest(dataRetrievable: dataRetrievableMock)
        let expected = MealPrograms.fake().programs.first?.id
        let items =  try await sut.fetchItems()
        
        XCTAssertEqual(items.first?.id, expected)
    }
    
    func test_GivenItemsToFetch_WhenFailed_ThenErrorIsThrown() async throws {
        var dataRetrievableMock = DataRequestableMock()
        dataRetrievableMock.shouldThrowError = true
        let sut = MealProgramRequest(dataRetrievable: dataRetrievableMock)
        
        do {
            _ = try await sut.fetchItems()
            XCTFail("Should throw file not found error")
        } catch {
            XCTAssertTrue(true)
        }
    }
}
