//
//  DataServiceProtocol.swift
//  ReleaseDatesApp
//
//  Created by Jason Bannister on 03/09/2021.
//

import Foundation

protocol DataService {
    func getData(completion: @escaping (TMDBStruct) -> Void)
}
