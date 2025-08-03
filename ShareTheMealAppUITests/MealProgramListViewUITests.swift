//
//  MealProgramListViewUITests.swift
//  ShareTheMealAppUITests
//
//

import XCTest
@testable import ShareTheMealApp

@MainActor
final class MealProgramListViewUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }
    
    func testScrollViewExists() {
        let scrollView = app.scrollViews[AccessibilityIdentifiers.mealProgramScrollView]
        XCTAssertTrue(scrollView.exists)
    }
    
    func testSearchBarExists() {
        let searchBarElement = app.searchFields[MealProgramsViewModel.searchBarPrompt]
        XCTAssertTrue(searchBarElement.exists)
    }
    
    func testNavigationTitleExists() {
        let searchBarElement = app.navigationBars[MealProgramsViewModel.navigationTitle]
        XCTAssertTrue(searchBarElement.exists)
    }
    
    func testSearchBarSearchesFiltersListForGivenTextAndReturnsEmptyListWhenItDoesntFindIt() {
        let expected = "Lorem"
        let searchBarElement = app.searchFields[MealProgramsViewModel.searchBarPrompt]
        searchBarElement.tap()
        searchBarElement.typeText(expected)
        let scrollView = app.scrollViews[AccessibilityIdentifiers.mealProgramScrollView]
        let filteredCell = scrollView.staticTexts[expected]
        
        let exists = filteredCell.waitForExistence(timeout: 2.0)
        
        XCTAssertFalse(exists)
    }
    
    func testSearchBarSearchesFiltersListForGivenTextAndReturnsCell() {
        // In a real scenario I would inject a JSON mock to make sure this title never changes, but for the sake of brevity I just did it like this.
        let expected = "Pastoral Communities Kenya"
        let searchBarElement = app.searchFields[MealProgramsViewModel.searchBarPrompt]
        searchBarElement.tap()
        searchBarElement.typeText(expected)
        let scrollView = app.scrollViews[AccessibilityIdentifiers.mealProgramScrollView]
        let filteredCell = scrollView.staticTexts[expected]
        
        let exists = filteredCell.waitForExistence(timeout: 2.0)
        
        XCTAssertTrue(exists)
    }
    
    func testTappingOnItemNavigatesToSubview() {
        let scrollview = app.scrollViews[AccessibilityIdentifiers.mealProgramScrollView]
        // In a real scenario I would inject a JSON mock to make sure this title never changes, but for the sake of brevity I just did it like this.
        let firstCell = scrollview.buttons.matching(identifier: "\(AccessibilityIdentifiers.mealProgramItemView)1").firstMatch
        
        firstCell.tap()
        
        let detail = app.otherElements[AccessibilityIdentifiers.mealProgramItemView]
        
        let exists = detail.waitForExistence(timeout: 2.0)
        
        XCTAssertTrue(exists)
    }
}
