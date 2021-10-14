//
//  FavouritesView.swift
//  ReleaseDatesApp
//
//  Created by Jason Bannister on 09/09/2021.
//
//  A list view with all of the movies that have a isFavourite value of 'True'. Fetched from the CoreData database, with navigation link re-using the MovieDetailView and MovieDetailViewModel.

import SwiftUI

struct FavouritesView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Movie.entity(), sortDescriptors: [], predicate: NSPredicate(format: "isFavourite = %d", true)) var favMovies: FetchedResults<Movie>
    
    var body: some View {
        NavigationView {
            Group {
                List(favMovies) { movie in
                    NavigationLink(destination: MovieDetailView(viewModel: MovieDetailViewModel(context: self.moc), movieId: Int(movie.id))) {
                        RemoteImageLoader(url: "https://image.tmdb.org/t/p/original\(movie.poster_path ?? "")")
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100)
                        
                        
                        VStack(alignment: .leading) {
                            Text(movie.wrappedTitle)
                                .font(.headline)
                            Text(movie.wrappedRelease_Date)
                                .font(.subheadline)
                            Text(movie.wrappedOverview)
                                .font(.caption)
                                .lineLimit(3)
                                .padding(.top, 5)
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Favourites"))
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
    }
}
