//
//  MovieStruct.swift
//  ReleaseDatesApp
//
//  Created by Jason Bannister on 03/09/2021.
//

import Foundation

struct MovieStruct: Codable, Identifiable {
    
    let id: Int
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String?
    let release_date: String
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
    
}

