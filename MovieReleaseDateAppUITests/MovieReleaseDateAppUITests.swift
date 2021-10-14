//
//  MovieReleaseDateAppUITests.swift
//  MovieReleaseDateAppUITests
//
//  Created by Jason Bannister on 14/09/2021.
//

import XCTest

class MovieReleaseDateAppUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testContentViewTabView() throws {
        // Given launch of app
        // When content view launches
        // Then TabView Appears with correct tab icons
        let tabBar = app.tabBars.element
        XCTAssert(tabBar.exists)
    
    }
    
    func testNavBar() throws {
        // Given
        let navBarTitle = app.staticTexts["Upcoming Movies"]
        let navBar = app.navigationBars.element
        // When - MovieReleaseView is visible view
        // Then
        XCTAssert(navBar.exists)
        XCTAssertEqual(navBarTitle.label, "Upcoming Movies")
    }
    
    func testTabButtonTapped() {
        // Given the TabView opens on MovieReleaseView
        let navBarTitle = app.staticTexts.element
        let navBar = app.navigationBars.element
        XCTAssert(navBar.exists)
        XCTAssertEqual(navBarTitle.label, "Upcoming Movies")
        
        // When - Favourites Tab tapped
        app.tabBars.buttons.element(boundBy: 1).tap()
        
        // Then - Confirm view changes and nav title updates
        XCTAssertEqual(navBarTitle.label, "Favourites")
    }
}
