//
//  MealProgramListViewUITests.swift
//  ShareTheMealAppUITests
//
//

import XCTest
@testable import ShareTheMealApp

@MainActor
final class MealProgramListViewUITests: XCTestCase {

    override func setUpWithError() throws {
        let app = XCUIApplication()
        app.launchEnvironment[DependencyContainer.uiTestMode] = "true"
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
