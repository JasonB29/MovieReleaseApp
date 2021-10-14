//
//  DetailViewUITests.swift
//  MovieReleaseDateAppUITests
//
//  Created by Jason Bannister on 16/09/2021.
//

import XCTest

class DetailViewUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app.launch()
        app.tables.buttons.firstMatch.tap()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFavouriteButton() {
        // Given MovieDetailView exists
        let detailView = app.scrollViews["MovieDetailView"].otherElements
        let movieImage = detailView.images["detailViewImage"]
        let favouriteButton = detailView.buttons["favorite"]
        let favSelected = detailView.buttons["favouriteSelected"]
        let favNotSelected = detailView.buttons["favouriteUnselected"]
        
        XCTAssert(favouriteButton.exists)
        XCTAssert(movieImage.exists)
        XCTAssert(favNotSelected.exists)
        // When
        favouriteButton.tap()
        
        // Then
        XCTAssert(favSelected.exists)
    
    }

}
