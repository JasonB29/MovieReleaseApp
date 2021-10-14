//
//  TMDBDataService.swift
//  ReleaseDatesApp
//
//  Created by Jason Bannister on 03/09/2021.
//

import Foundation
import CoreData

class TMDBDataService: DataService {
    
    // DataService for networking calls to the TMDB server. Parameters for the HTTP query are stored in the UserDefaults.
    // The response from the network call is decoded into a data struct. 
    func getData(completion: @escaping (TMDBStruct) -> Void) {
        let api_key = UserDefaults.standard.string(forKey: "API_KEY")
        let language = UserDefaults.standard.string(forKey: "LANGUAGE")
        let region = UserDefaults.standard.string(forKey: "REGION")
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=\(api_key ?? "")&language=\(language ?? "en")&page=1&region=\(region ?? "GB")")
        
        let request = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown Error")")
                return
            }
            
            DispatchQueue.main.async {
            do {
                
                let decoder = JSONDecoder()
                let decodedTMDBResponse = try decoder.decode(TMDBStruct.self, from: data)
                completion(decodedTMDBResponse)
            } catch let error {
                print("error: \(error)")
                }
            }
            
        }.resume()
    }
    
}
