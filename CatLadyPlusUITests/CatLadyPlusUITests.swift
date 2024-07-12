//
//  CatLadyPlusUITests.swift
//  CatLadyPlusUITests
//
//  Created by Adelino Faria on 11/07/2024.
//

import XCTest

final class CatLadyPlusUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let title = app.navigationBars.staticTexts.firstMatch
        let searchBar = app.navigationBars.searchFields.firstMatch
        let firstCellStaticText = app.scrollViews.firstMatch.staticTexts["CatBreedListCellView"].firstMatch

        XCTAssertEqual(title.label, "Compendium")
        XCTAssertEqual(searchBar.label, "Breeds of cats")
        XCTAssertEqual(firstCellStaticText.label, "Abyssinian")

        firstCellStaticText.tap()

        let detailTitle = app.navigationBars.staticTexts.firstMatch

        XCTAssertEqual(detailTitle.label, "Abyssinian")

        let navBack = app.navigationBars.firstMatch.buttons.firstMatch

        navBack.tap()

        let rootTitle = app.navigationBars.staticTexts.firstMatch

        XCTAssertEqual(rootTitle.label, "Compendium")

        let lastCellStaticText = app.scrollViews.firstMatch.staticTexts["York Chocolate"]

        while !lastCellStaticText.exists {

            app.swipeUp()
        }

        XCTAssertEqual(lastCellStaticText.label, "York Chocolate")

        lastCellStaticText.tap()

        XCTAssertEqual(app.buttons.firstMatch.exists, true)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
