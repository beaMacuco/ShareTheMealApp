//
//  MealProgramCardViewUITests.swift
//  ShareTheMealAppUITests
//
//  Created by Beatriz Loures Macuco on 03.08.25.
//

import XCTest
@testable import ShareTheMealApp

class MealProgramCardViewUITests: XCTestCase {
    var app: XCUIApplication!
    var firstCell: XCUIElement!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
        let scrollview = app.scrollViews[AccessibilityIdentifiers.mealProgramScrollView]
        // In a real scenario I would inject a JSON mock to make sure this title never changes, but for the sake of brevity I just did it like this.
        firstCell = scrollview.buttons.matching(identifier: "\(AccessibilityIdentifiers.mealProgramItemView)1").firstMatch
    }
    
    func testCellDisplaysMealProgramHeaderImage() {
        let image = firstCell.images[AccessibilityIdentifiers.overlayImageView]
        let exists = image.waitForExistence(timeout: 2.0)
        
        XCTAssertTrue(exists)
    }
    
    func testCellDisplaysMealProgramTitle() {
        let title = firstCell.staticTexts[AccessibilityIdentifiers.overlayHeaderView]
        let exists = title.waitForExistence(timeout: 2.0)
        
        XCTAssertTrue(exists)
    }
    
    func testCellDisplaysMealProgramTag() {
        let tag = firstCell.staticTexts[AccessibilityIdentifiers.mealProgramTagText]
        let exists = tag.waitForExistence(timeout: 2.0)
        
        XCTAssertTrue(exists)
    }
    
    func testCellDisplaysMealProgramProgressView() {
        let progress = firstCell.progressIndicators.firstMatch
        let exists = progress.waitForExistence(timeout: 2.0)
        
        XCTAssertTrue(exists)
    }
    
    func testCellDisplaysMealProgramAmounts() {
        let amounts = firstCell.staticTexts[AccessibilityIdentifiers.mealProgramAmountText]
        let exists = amounts.waitForExistence(timeout: 2.0)
        
        XCTAssertTrue(exists)
    }
    
    func testCellDisplaysMealProgramProgressPercentage() {
        let progressPercentage = firstCell.staticTexts[AccessibilityIdentifiers.mealProgramProgressPercentageText]
        let exists = progressPercentage.waitForExistence(timeout: 2.0)
        
        XCTAssertTrue(exists)
    }
}
