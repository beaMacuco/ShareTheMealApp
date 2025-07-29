//
//  MealProgramRequestTests.swift
//  ShareTheMealAppTests
//
//  Created by Beatriz Loures Macuco on 23.07.25.
//

import XCTest
@testable import ShareTheMealApp

final class MealProgramRequestTests: XCTestCase {

    func test_GivenLoadMealProgramsCalled_ThenJsonMealProgramsLoaderIsCalled() async throws {
        let localJsonReaderMock = LocalJsonReaderMock()
        let sut = MealProgramRequest(mealProgramLocalJsonReader: localJsonReaderMock)
        do {
            try await sut.loadMealPrograms()
            XCTAssertTrue(localJsonReaderMock.isLoaded)
        } catch {
            XCTFail("Should call meal programs loader")
        }
    }
    
    func test_GivenSearchItems_WhenEmptyQuery_ThenEmptyArrayIsReturned() throws {
        let localJsonReaderMock = LocalJsonReaderMock()
        localJsonReaderMock.programs = [MealProgram.fake(), MealProgram.fake()]
        let sut = MealProgramRequest(mealProgramLocalJsonReader: localJsonReaderMock)
        let items = sut.searchItems(query: "")
        
        XCTAssertTrue(items.isEmpty)
    }
    
    func test_GivenSearchItems_WhenItemsForQueryExists_ThenItemsAreReturned() throws {
        let localJsonReaderMock = LocalJsonReaderMock()
        localJsonReaderMock.programs = [MealProgram.fake(), MealProgram.fake()]
        let sut = MealProgramRequest(mealProgramLocalJsonReader: localJsonReaderMock)
        let items = sut.searchItems(query: MealProgram.fake().name)
        
        XCTAssertTrue(items.count == localJsonReaderMock.programs.count)
    }
    
    func test_GivenFetch_WhenEndOfListIsReached_ThenEmptyArrayReturned() throws {
        let localJsonReaderMock = LocalJsonReaderMock()
        localJsonReaderMock.programs = [MealProgram.fake(), MealProgram.fake()]
        let count = 10
        localJsonReaderMock.programCount = count
        let sut = MealProgramRequest(mealProgramLocalJsonReader: localJsonReaderMock)
        let items = sut.fetchPage(offset: count + 1)
        
        XCTAssertTrue(items.isEmpty)
    }
    
    func test_GivenFetch_WhenEndOfListNotReached_ThenPageReturned() throws {
        let localJsonReaderMock = LocalJsonReaderMock()
        localJsonReaderMock.programs = [MealProgram.fake(), MealProgram.fake()]
        localJsonReaderMock.programCount = 10
        let sut = MealProgramRequest(mealProgramLocalJsonReader: localJsonReaderMock)
        let items = sut.fetchPage(offset: 1)
        
        XCTAssertFalse(items.isEmpty)
    }
}
