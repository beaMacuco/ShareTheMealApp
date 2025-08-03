//
//  MealProgramLocalJsonReaderTests.swift
//  ShareTheMealAppTests
//
//

import XCTest
@testable import ShareTheMealApp

final class MealProgramLocalJsonReaderTests: XCTestCase {
    
    func testLoadProgramFetchesItems() {
        do {
            var mock = DataRequestableMock()
            let mealProgram = MealProgram.fake()
            mock.mealPrograms = MealPrograms(programs: [mealProgram])
            let sut = MealProgramLocalJsonReader(dataRequestable: mock)
            try sut.loadPrograms()
            XCTAssertFalse(sut.mealPrograms.isEmpty)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testFilterProgramsFiltersByName() {
        do {
            var mock = DataRequestableMock()
            let mealProgram = MealProgram.fake()
            mock.mealPrograms = MealPrograms(programs: [mealProgram])
            let sut = MealProgramLocalJsonReader(dataRequestable: mock)
            try sut.loadPrograms()
            let result = sut.filterPrograms(query: mealProgram.name)
            
            XCTAssert(result.first?.name == mealProgram.name)
            
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testFilterProgramsFiltersByCountry() {
        do {
            var mock = DataRequestableMock()
            let mealProgram = MealProgram.fake()
            mock.mealPrograms = MealPrograms(programs: [mealProgram])
            let sut = MealProgramLocalJsonReader(dataRequestable: mock)
            try sut.loadPrograms()
            let result = sut.filterPrograms(query: mealProgram.country)
            
            XCTAssert(result.first?.country == mealProgram.country)
            
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testFetchCurrentPageFetchesCorrectItems() {
        do {
            var mock = DataRequestableMock()
            let mealProgramArray = [MealProgram.fake(id: 1), MealProgram.fake(id: 2), MealProgram.fake(id: 3), MealProgram.fake(id: 4),MealProgram.fake(id: 5)]
            mock.mealPrograms = MealPrograms(programs: mealProgramArray)
            let sut = MealProgramLocalJsonReader(dataRequestable: mock)
            try sut.loadPrograms()
            let result = sut.fetchCurrentPage(offset: 2, end: 5)
            let expected = [MealProgram.fake(id: 3), MealProgram.fake(id: 4),MealProgram.fake(id: 5)]
            
            XCTAssertEqual(expected.map { $0.id }, result.map { $0.id })
            
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testCountProgramsReturnsCorrectAmountOfMealPrograms() {
        do {
            var mock = DataRequestableMock()
            let mealProgramArray = [MealProgram.fake(id: 1), MealProgram.fake(id: 2), MealProgram.fake(id: 3), MealProgram.fake(id: 4),MealProgram.fake(id: 5)]
            mock.mealPrograms = MealPrograms(programs: mealProgramArray)
            let sut = MealProgramLocalJsonReader(dataRequestable: mock)
            try sut.loadPrograms()
            let result = sut.countPrograms()
            
            XCTAssertEqual(mealProgramArray.count, result)
            
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
