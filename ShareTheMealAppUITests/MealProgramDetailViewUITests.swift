//
//  MealProgramDetailViewUITests.swift
//  ShareTheMealAppUITests
//
//  Created by Beatriz Loures Macuco on 03.08.25.
//

import XCTest
@testable import ShareTheMealApp

class MealProgramDetailViewUITests: XCTestCase {
    var app: XCUIApplication!
    var detail: XCUIElement!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
        let scrollview = app.scrollViews[AccessibilityIdentifiers.mealProgramScrollView]
        // In a real scenario I would inject a JSON mock to make sure this title never changes, but for the sake of brevity I just did it like this.
        let firstCell = scrollview.buttons.matching(identifier: "\(AccessibilityIdentifiers.mealProgramItemView)1").firstMatch
        firstCell.tap()
        
        detail = app.otherElements[AccessibilityIdentifiers.mealProgramItemView]
    }
    
    func testDetailViewDisplaysMealProgramHeaderImage() {
        let image = detail.images[AccessibilityIdentifiers.overlayImageView]
        let exists = image.waitForExistence(timeout: 2.0)
        
        XCTAssertTrue(exists)
    }
    
    func testDetailViewDisplaysMealProgramTitle() {
        let title = detail.staticTexts[AccessibilityIdentifiers.overlayHeaderView]
        let exists = title.waitForExistence(timeout: 2.0)
        
        XCTAssertTrue(exists)
    }
    
    func testDetailViewDisplaysMealProgramTag() {
        let tag = detail.staticTexts[AccessibilityIdentifiers.mealProgramTagText]
        let exists = tag.waitForExistence(timeout: 2.0)
        
        XCTAssertTrue(exists)
    }
    
    func testDetailViewDisplaysMealProgramSummaryTitle() {
        let summaryTitle = detail.staticTexts[AccessibilityIdentifiers.summaryTitle].firstMatch
        let exists = summaryTitle.waitForExistence(timeout: 2.0)
        
        XCTAssertTrue(exists)
    }
    
    func testDetailViewDisplaysMealProgramDescription() {
        let description = detail.staticTexts[AccessibilityIdentifiers.mealProgramDescription]
        let exists = description.waitForExistence(timeout: 2.0)
        
        XCTAssertTrue(exists)
    }
    
    func testDetailViewDisplaysMealProgramDonateButton() {
        let donateButton = detail.buttons[AccessibilityIdentifiers.donateButton]
        let exists = donateButton.waitForExistence(timeout: 2.0)
        
        XCTAssertTrue(exists)
    }
    
    func testWhenDonateButtonTappedThenAlertIsShown() {
        let donateButton = detail.buttons[AccessibilityIdentifiers.donateButton]
        donateButton.tap()
        
        let alert = app.alerts[MealProgramItemViewModel.alertTitle]
        let exists = alert.waitForExistence(timeout: 2.0)
        
        XCTAssertTrue(exists)
    }
    
    func testWhenOkButtonOnDonateAlertTappedThenAlertIsDismissed() {
        let donateButton = detail.buttons[AccessibilityIdentifiers.donateButton]
        donateButton.tap()
        
        let alert = app.alerts[MealProgramItemViewModel.alertTitle]
        let okButton = alert.buttons[MealProgramItemViewModel.dismissButtonTitle]
        okButton.tap()
        
        XCTAssertFalse(alert.waitForExistence(timeout: 2.0))
    }
    
    func testWhenBackButtonTappedThenParentViewIsShown() {
        let navigation = app.navigationBars.element(boundBy: 0)
        guard navigation.waitForExistence(timeout: 2.0) else {
            XCTFail("Navigation bar didn't appear")
            return
        }
        let backButton = navigation.buttons[AccessibilityIdentifiers.dismissButton]
        
        backButton.tap()

        XCTAssertFalse(detail.waitForExistence(timeout: 2.0))
    }
}
