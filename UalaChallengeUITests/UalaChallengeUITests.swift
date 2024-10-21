//
//  UalaChallengeUITests.swift
//  UalaChallengeUITests
//
//  Created by Leandro Berli on 16/10/2024.
//

import XCTest

final class UalaChallengeUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testNavigationToCityInfoScreen() throws {
        let firstCityCell = app.staticTexts["A Guarda, ES"]
        XCTAssertTrue(firstCityCell.waitForExistence(timeout: 100))
        firstCityCell.tap()
        
        let infoButton = app.buttons["See city information"]
        infoButton.tap()
        
        let countryText = app.staticTexts["Country: ES"]
        let nameText = app.staticTexts["Name: A Guarda"]
        let lonText = app.staticTexts["latitude: -8,874230"]
        let latText = app.staticTexts["longitude: 41,901310"]
        
        XCTAssertTrue(countryText.waitForExistence(timeout: 3))
        XCTAssertTrue(nameText.waitForExistence(timeout: 3))
        XCTAssertTrue(lonText.waitForExistence(timeout: 3))
        XCTAssertTrue(latText.waitForExistence(timeout: 3))
    }
}
