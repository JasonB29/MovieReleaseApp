//
//  MovieDetailViewModel.swift
//  ReleaseDatesApp
//
//  Created by Jason Bannister on 10/09/2021.
//

import SwiftUI
import CoreData

class MovieDetailViewModel: ObservableObject {
    
    var moc: NSManagedObjectContext?
    
    init(context: NSManagedObjectContext? = nil) {
        self.moc = context
    }
    
    // The function updates the Boolean value for whether the movie has been favourited, then saves it to the database.
    func updateFavourites(movie: Movie) {
        movie.isFavourite = !movie.isFavourite
        do {
            try self.moc?.save()
            print("Favourite saved to CD")
        } catch let error {
            print("Could not save data \(error.localizedDescription)")
        }
    }
    
}
