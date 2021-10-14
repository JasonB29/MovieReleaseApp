//
//  TMDBStruct.swift
//  ReleaseDatesApp
//
//  Created by Jason Bannister on 03/09/2021.
//

import Foundation


struct TMDBStruct: Codable {
    let dates: Dates?
    let results: [MovieStruct]?
}

struct Dates: Codable {
    let maximum: String
    let minimum: String
}


