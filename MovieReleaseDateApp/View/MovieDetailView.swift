//
//  MovieDetailView.swift
//  ReleaseDatesApp
//
//  Created by Jason Bannister on 06/09/2021.
//
// DetailView page presents more information regarding the selected movie. It fetches the movie from the
// CoreData database using the movie ID passed in. The view also enables a 'favourite' switch that gets
// toggled on and off by a tap gesture, which calls an update method in the MovieDetailViewModel. 

import SwiftUI
import CoreData

struct MovieDetailView: View {
    
    
    @StateObject var detailViewModel: MovieDetailViewModel
    var fetchRequest: FetchRequest<Movie>
    var movie: Movie! { fetchRequest.wrappedValue.first }
    
    init(viewModel: MovieDetailViewModel, movieId: Int) {
        _detailViewModel = StateObject(wrappedValue: viewModel)
        
        fetchRequest = FetchRequest<Movie>(entity: Movie.entity(), sortDescriptors: [], predicate: NSPredicate(format: "id == %i", movieId))
    }
    
    var body: some View {
        GeometryReader { movieView in
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.white, Color.black]), startPoint: .top, endPoint: .bottom)
                ScrollView(.vertical) {
                    VStack {
                        GeometryReader { movieImage in
                            RemoteImageLoader(url: "https://image.tmdb.org/t/p/original\(movie.wrappedPoster_Path )")
                                .scaledToFit()
                                .frame(width: movieView.size.width * 0.7, height: movieView.size.width * 0.7, alignment: .bottom)
                                .position(x: movieImage.size.width / 2, y: movieImage.size.height / 2)
                        }
                        .frame(height: movieView.size.width * 0.7)
                        .accessibilityIdentifier("detailViewImage")
                        
                        HStack {
                            Text(movie.wrappedTitle)
                                .padding()
                                .font(.title)
                            
                            VStack {
                                
                                HStack {
                                    Text("\(Int(movie.vote_average))")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .padding(-5)
                                    Text("/10")
                                        .font(.subheadline)
                                    }
                                .padding(.top, 5)
                                .padding(.bottom, 5)
                                
                                Text("Release Date: \(movie.wrappedRelease_Date)")
                                    .font(.subheadline)
                                
                                Button(action: {
                                    // Calls a method in the ViewModel that handles the updating of the database with the new value for isFavourite
                                    detailViewModel.updateFavourites(movie: movie)
                                }) {
                                    if movie.isFavourite {
                                        Image(systemName: "star.fill")
                                            .accessibilityIdentifier("favouriteSelected")
                                    } else {
                                        Image(systemName: "star")
                                            .accessibilityIdentifier("favouriteUnselected")
                                    }
                                }
                                .font(.headline)
                                .padding(5)
                                .foregroundColor(.yellow)
                            }
                        }
                        
                        
                       
                        
                        Text(movie.wrappedOverview)
                            .padding()
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .foregroundColor(.white)
                }
            }
        }
        .accessibilityIdentifier("MovieDetailView")
    }
}

struct MovieDetailView_Previews: PreviewProvider {

    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
    
        let movie = Movie(context: moc)
        movie.id = 1
        movie.title = "The Matrix"
        movie.overview = "Neo rescues the human race"
        movie.original_title = "The matrix reloaded"
        movie.original_language = "eng"
        movie.popularity = 10
        movie.poster_path = "/aYCdTgtDoT9tvQobspgSfydswh8.jpg"
        movie.release_date = "29-06-2004"
        movie.vote_average = 10
        movie.isFavourite = true
   
        return MovieDetailView(viewModel: MovieDetailViewModel(), movieId: 1)
            
        
    }
}
