//
//  MovieReleaseViewModel.swift
//  ReleaseDatesApp
//
//  Created by Jason Bannister on 03/09/2021.
//

import SwiftUI
import CoreData

class MovieReleaseViewModel: ObservableObject {
    
    enum LoadingState {
        case loading, success
    }
    
    @Published var movies = [MovieStruct]()
    @Published var loadingState = LoadingState.loading
    var CDMovieIds: [Int] = []
    var moc: NSManagedObjectContext
    let dataService: DataService
    
    // When the ViewModel is initialised, a class that conforms to the DataServiceProtocol is passed in to handle the
    // networking call to the fetch the JSON data.
    init(dataService: DataService = TMDBDataService(), context: NSManagedObjectContext) {
        self.dataService = dataService
        self.moc = context
    }
    
    func getMovies() {
        dataService.getData { [weak self] movies in
            self?.movies = movies.results ?? []
            if self!.movies.count == 0 {
                self?.loadingState = LoadingState.loading
            } else {
                self?.loadingState = LoadingState.success
                self!.saveToCD()
            }
        }
        
    }
    
    
    // Function used to save the fetched network data to the CoreData database. The function first checks an
    // array containing the movie IDs to see if the current movie ID is present. If not, then it saves the
    // movie to the database, otherwise it continues to the next object to be cross-checked.
    func saveToCD() {
        print("SaveToCD Called!")
        DispatchQueue.main.async {
            for movie in self.movies {
                if self.CDMovieIds.contains(movie.id) { continue }
                let movieToSave = Movie(context: self.moc)
                movieToSave.id = Int32(movie.id)
                movieToSave.original_language = movie.original_language
                movieToSave.original_title = movie.original_title
                movieToSave.overview = movie.overview
                movieToSave.popularity = Int16(movie.popularity)
                movieToSave.poster_path = movie.poster_path
                movieToSave.release_date = movie.release_date
                movieToSave.title = movie.title
                movieToSave.vote_average = Int16(movie.vote_average)
                    do {
                        if self.moc.hasChanges {
                        try self.moc.save()
                            print("Saved to CD") }
                    } catch let error {
                        print("Could not save data \(error.localizedDescription)")
                    }
                
            }
            
        }
    }
}
