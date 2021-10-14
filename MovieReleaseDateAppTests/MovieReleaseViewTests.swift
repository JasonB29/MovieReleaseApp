//
//  MovieReleaseViewTests.swift
//  ReleaseDatesAppTests
//
//  Created by Jason Bannister on 13/09/2021.
//

import XCTest
import CoreData
@testable import MovieReleaseDateApp

class MockDataService: DataService {
    func getData(completion: @escaping (TMDBStruct) -> Void) {
        completion(TMDBStruct(dates: nil, results: [MovieStruct(id: 1, original_language: "En", original_title: "The Matrix", overview: "Neo saves the world and shoots a lot of bullets", popularity: 10, poster_path: nil, release_date: "11-06-1999", title: "The Matrix", video: false, vote_average: 10, vote_count: 10)]))
    }
}

class MovieReleaseViewTests: XCTestCase {
    
    var sut: MovieReleaseView!
    let context = TestCoreDataStack().mockPersistantContainer.newBackgroundContext()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let viewModel = MovieReleaseViewModel.init(dataService: MockDataService(), context: context)
        expectation(forNotification: .NSManagedObjectContextDidSave, object: context) { _ in
            return true
        }
        sut = MovieReleaseView.init(viewModel: viewModel)
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testGetData() throws {
        
        // Given an empty viewModel
        XCTAssertTrue(sut.viewModel.movies.isEmpty)
    
        // When getMovies is called on MockDataService
        sut.viewModel.getMovies()
        
        // Then movies struct should have 1 movie
        XCTAssertEqual(sut.viewModel.movies.count, 1)
        XCTAssertEqual(sut.viewModel.movies[0].title, "The Matrix")
    }
    
    func testLoadingState() throws {
        
        // Given onAppear
        XCTAssertTrue(sut.viewModel.loadingState == .loading)
       
        // When getMovies is called by dataService
        sut.viewModel.getMovies()
       
        // Then the loading state changes to success
        XCTAssertTrue(sut.viewModel.loadingState == .success)
    }
    
    func testCoreDate() throws {
        // Given a call to MockDataService
        // When a data is received and saved to CoreData
        sut.viewModel.getMovies()
        
        // Then Expectation for .NSManagedObjectContextDidSave to confirm save function completed.
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }

}
