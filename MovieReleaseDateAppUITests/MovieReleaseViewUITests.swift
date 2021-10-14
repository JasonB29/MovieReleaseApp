//
//  MovieReleaseViewUITests.swift
//  MovieReleaseDateAppUITests
//
//  Created by Jason Bannister on 15/09/2021.
//

import XCTest

class MovieReleaseViewUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

    func testSettingsButton() {
        // Given app launch
        let navBarTitle = app.staticTexts["Settings"]
        let settingsButton = app.navigationBars.buttons["settings"]
        XCTAssert(settingsButton.exists)
       
        // When settings button tapped
        settingsButton.tap()
        
        // Then - confirm sheet is displayed with SettingsView by looking for nav title "Settings"
        XCTAssertEqual(navBarTitle.label, "Settings")
    }
    
    func testMovieNavLinks() {
        // Given MovieReleaseView
        let movieNavLink = app.tables.buttons.firstMatch
        let detailView = app.scrollViews["MovieDetailView"].otherElements
        let navBarButton = app.navigationBars.buttons["Upcoming Movies"]
        let movieImage = detailView.images["detailViewImage"]
        // When movie tapped
        movieNavLink.tap()
        
        // Then shows MovieDetailView
        XCTAssert(detailView.buttons["favorite"].exists)
        XCTAssert(navBarButton.exists)
        XCTAssert(movieImage.exists)
        
    }

}


