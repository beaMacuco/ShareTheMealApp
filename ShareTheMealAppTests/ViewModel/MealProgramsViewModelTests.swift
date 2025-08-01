//
//  MealProgramsViewModelTests.swift
//  ShareTheMealAppTests
//
//

import Combine
import XCTest
@testable import ShareTheMealApp

@MainActor
final class MealProgramsViewModelTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()
    
    func testVisibleMealProgramsIsEmptyInitially() {
        let mock = MealProgramRequestMock()
        let sut = MealProgramsViewModel(mealProgramRequest: mock)
        XCTAssertTrue(sut.visibleMealPrograms.isEmpty)
    }
    
    func testFilteredMealProgramsIsEmptyInitially() {
        let mock = MealProgramRequestMock()
        let sut = MealProgramsViewModel(mealProgramRequest: mock)
        XCTAssertTrue(sut.filteredMealPrograms.isEmpty)
    }
    
    func testInitialPagingOffsetIsZero() {
        let mock = MealProgramRequestMock()
        let sut = MealProgramsViewModel(mealProgramRequest: mock)
        XCTAssertTrue(sut.offset == 0)
    }
    
    func testErrorLoadingInitialDataIsSentToViewState() async {
        let mock = MealProgramRequestMock()
        mock.throwError = true
        let sut = MealProgramsViewModel(mealProgramRequest: mock)
        await sut.loadInitialDataIfNeeded()
        
        XCTAssertTrue(sut.viewState == .error(MealProgramsViewModel.errorMessage))
    }
    
    func testLoadInitialDataLoadsVisibleMealPrograms() async {
        let mock = MealProgramRequestMock()
        mock.mealPrograms = [MealProgram.fake(), MealProgram.fake()]
        let sut = MealProgramsViewModel(mealProgramRequest: mock)
        await sut.loadInitialDataIfNeeded()
        XCTAssertFalse(sut.visibleMealPrograms.isEmpty)
    }
    
    func testLoadInitialDataLoadsFilteredeMealPrograms() async {
        let mock = MealProgramRequestMock()
        mock.mealPrograms = [MealProgram.fake(), MealProgram.fake()]
        let sut = MealProgramsViewModel(mealProgramRequest: mock)
        await sut.loadInitialDataIfNeeded()
        XCTAssertFalse(sut.filteredMealPrograms.isEmpty)
    }
    
    func testLoadInitialDataSetsNewPageToCurrentAddedItemsCount() async {
        let mock = MealProgramRequestMock()
        mock.mealPrograms = [MealProgram.fake(), MealProgram.fake()]
        let sut = MealProgramsViewModel(mealProgramRequest: mock)
        await sut.loadInitialDataIfNeeded()
        XCTAssertEqual(mock.mealPrograms.count, sut.offset)
    }
    
    func testLoadInitialDataSetsViewStateToLoaded() async {
        let mock = MealProgramRequestMock()
        let sut = MealProgramsViewModel(mealProgramRequest: mock)
        await sut.loadInitialDataIfNeeded()
        XCTAssertTrue(sut.viewState == .loaded)
    }
    
    func testSearchFilterIsAppliedWhenSearchTextIsUsed() async {
        let mock = MealProgramRequestMock()
        let expected = "test"
        let mealProgram1 = MealProgram.fake(name: expected)
        let mealProgram2 = MealProgram.fake(name: "name")
        mock.mealPrograms = [mealProgram1, mealProgram2]
        let sut = MealProgramsViewModel(mealProgramRequest: mock)
        await sut.loadInitialDataIfNeeded()
        sut.searchText = expected
        
        let expectation = XCTestExpectation()
        
        sut.$filteredMealPrograms
            .sink { values in
                XCTAssertEqual(values.first?.name, expected)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        await fulfillment(of: [expectation], timeout: 0.5)
    }
    
    func testSearchFilterIsNotAppliedAndAllValuesAreReturnedIfNoSearchMatch() async {
        let mock = MealProgramRequestMock()
        mock.mealPrograms = [MealProgram.fake(), MealProgram.fake()]
        let sut = MealProgramsViewModel(mealProgramRequest: mock)
        await sut.loadInitialDataIfNeeded()
        sut.searchText = "expected"
        
        let expectation = XCTestExpectation()
        
        sut.$filteredMealPrograms
            .sink { values in
                XCTAssertEqual(values.count, mock.mealPrograms.count)
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        await fulfillment(of: [expectation], timeout: 0.5)
    }
    
    func testShouldFetchMoreDoesNotFetchIfNotYetWithinThreshold() async {
        let mock = MealProgramRequestMock()
        let currentItem = MealProgram.fake(id: 2)
        mock.mealPrograms = [MealProgram.fake(id: 1), currentItem, MealProgram.fake(id: 3), MealProgram.fake(id: 4)]
        let sut = MealProgramsViewModel(mealProgramRequest: mock)
        await sut.loadInitialDataIfNeeded()
        
        sut.fetchMoreIfNeeded(currentItem: currentItem)
        
        XCTAssertEqual(mock.mealPrograms.count, sut.visibleMealPrograms.count)
    }
    
    func testShouldFetchMoreFetchesMoreIfWithinThreshold() async {
        let mock = MealProgramRequestMock()
        let currentItem = MealProgram.fake(id: 3)
        mock.mealPrograms = [MealProgram.fake(id: 1), MealProgram.fake(id: 2), currentItem, MealProgram.fake(id: 4)]
        let sut = MealProgramsViewModel(mealProgramRequest: mock)
        await sut.loadInitialDataIfNeeded()
        
        sut.fetchMoreIfNeeded(currentItem: currentItem)
        
        XCTAssertNotEqual(mock.mealPrograms.count, sut.visibleMealPrograms.count)
    }
}
