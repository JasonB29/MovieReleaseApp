//
//  RemoteImageLoader.swift
//  ReleaseDatesApp
//
//  Created by Jason Bannister on 06/09/2021.
//

import SwiftUI

struct RemoteImageLoader: View {
    
    private enum LoadState {
        case loading, success, failure
    }
    
    private class Loader: ObservableObject {
        var data = Data()
        var state = LoadState.loading
    
    init(url: String) {
        guard let parsedURL = URL(string: url) else {
            fatalError("\(url) is an invalid URL.")
        }
        
        URLSession.shared.dataTask(with: parsedURL) { data, response, error in
            if let data = data, data.count > 0 {
                self.data = data
                self.state = .success
            } else {
                self.state = .failure
                }
            
            DispatchQueue.main.async {
                self.objectWillChange.send()
                }
            
            }.resume()
        }
    }
    
    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image
    
    var body: some View {
        selectImage()
            .resizable()
    }
    
    init(url: String, loading: Image = Image(systemName: "film"), failure: Image = Image(systemName: "multiply.circle")) {
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.failure = failure
    }
    
    private func selectImage() -> Image {
        switch loader.state {
           case .loading:
               return loading
           case .failure:
               return failure
           default:
               if let image = UIImage(data: loader.data) {
                   return Image(uiImage: image)
               } else {
                   return failure
               }
           }
       }
    
}

struct RemoteImageLoader_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImageLoader(url: "https://image.tmdb.org/t/p/w500/kqjL17yufvn9OVLyXYpvtyrFfak.jpg")
    }
}
