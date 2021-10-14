//
//  ReleaseDateView.swift
//  ReleaseDatesApp
//
//  Created by Jason Bannister on 03/09/2021.
//

// View that displays all the movies fetched from the TMDB query. If the API key is not present
// the view will display a button that navigates to the settings page.
// Each movie image has a navigation link that takes the user to a movie details page.

import SwiftUI
import CoreData

struct MovieReleaseView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Movie.entity(), sortDescriptors: []) var CDMovies: FetchedResults<Movie>
    @StateObject var viewModel: MovieReleaseViewModel
    @State private var showSettings = false
    
    init(viewModel: MovieReleaseViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.loadingState == .success {
                    List(viewModel.movies) { movie in
                        NavigationLink(destination: MovieDetailView(viewModel: MovieDetailViewModel(context: self.moc), movieId: movie.id)) {
                            RemoteImageLoader(url: "https://image.tmdb.org/t/p/original\(movie.poster_path ?? "")")
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100)
                            
                            VStack(alignment: .leading) {
                                Text(movie.title)
                                    .font(.headline)
                                Text(movie.release_date)
                                    .font(.subheadline)
                                Text(movie.overview)
                                    .font(.caption)
                                    .lineLimit(3)
                                    .padding(.top, 5)
                            }
                        }
                    }
                } else {
                    // Check to see if there is a valid API_KEY to access the TMDB Service
                    ((UserDefaults.standard.string(forKey: "API_KEY") != nil) ? Text("Fetching Movies") : Text("Tap here to enter settings"))
                        .onTapGesture {
                            self.showSettings = true
                        }
                        .accessibilityIdentifier("launchMessageButton")
                }
            }
            .navigationBarTitle(Text("Upcoming Movies"), displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showSettings = true
                        
                    }) {
                        Image(systemName: "gear")
                    }
                }
            }
            .sheet(isPresented: $showSettings, onDismiss: viewModel.getMovies, content: {
                SettingsView()
            })
            .onAppear{
                for movie in self.CDMovies {
                    self.viewModel.CDMovieIds.append(Int(movie.id))
                }
                viewModel.getMovies()
            }
        }
          
    }
}

struct ReleaseDateView_Previews: PreviewProvider {
    static var previews: some View {
        
        let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        let movie = MovieStruct(id: 1, original_language: "Eng", original_title: "Dummy Movie", overview: "Dummy movie to test preview", popularity: 10, poster_path: "/aYCdTgtDoT9tvQobspgSfydswh8.jpg", release_date: "29-06-1985", title: "Dummy Movie", video: false, vote_average: 10, vote_count: 5)
        
        let viewModel = MovieReleaseViewModel(context: moc)
        viewModel.movies = [movie]
        
        return MovieReleaseView(viewModel: viewModel)
    }
}
