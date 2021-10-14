//
//  ContentView.swift
//  MovieReleaseDateApp
//
//  Created by Jason Bannister on 14/09/2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        TabView {
            MovieReleaseView(viewModel: MovieReleaseViewModel(context: self.moc))
                .tabItem {
                    Image(systemName: "film")
                }
            
            FavouritesView()
                .tabItem {
                    Image(systemName: "star")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
