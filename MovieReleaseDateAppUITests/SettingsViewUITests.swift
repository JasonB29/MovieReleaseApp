//
//  SettingsViewUITests.swift
//  MovieReleaseDateAppUITests
//
//  Created by Jason Bannister on 16/09/2021.
//

import XCTest

class SettingsViewUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app.launch()
        app.buttons["settings"].tap()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    func testNavBar() {
        // Given - Navigation to settings sheet
        let navBar = app.navigationBars.element
        let navBarTitle = app.navigationBars.staticTexts["Settings"]
        
        // When - Settings Sheets appears
        
        // Then - Settings Navigation Bar is present
        XCTAssert(navBar.exists)
        XCTAssertEqual(navBarTitle.label, "Settings")
        
    }
    
    func testApiTextField() {
        // Given
        let apiTextField = app.textFields["API TextField"]
        let clearButton = app.tables.buttons["close"]
        
        // When
        apiTextField.tap()
        clearButton.tap()
        apiTextField.typeText("test api")
        
        // Then
        XCTAssertEqual(apiTextField.value as! String, "test api")
    }
    
    func testLanguagePicker() {
        
        // Given
        let picker = app.segmentedControls["languagePicker"]
        XCTAssert(picker.exists)
        
        // When
        picker.buttons["French"].tap()
        
        // Then
        XCTAssert(picker.buttons["French"].isSelected)
        
    }
    
    func testRegionPicker() {
        // Given
        let picker = app.segmentedControls["regionPicker"]
        XCTAssert(picker.exists)
        XCTAssert(picker.buttons["GB"].isSelected)
        // When
        picker.buttons["US"].tap()
        
        // Then
        XCTAssert(picker.buttons["US"].isSelected)
    }
    
    func testSaveButton() {
        // Given
        let navBarTitle = app.navigationBars["Settings"].staticTexts["Settings"]
        let saveButton = app.buttons["Save"]
        XCTAssert(saveButton.exists)
        
        // When
        saveButton.tap()
        
        // Then
        XCTAssertFalse(navBarTitle.waitForExistence(timeout: 1.0))
    }

}
