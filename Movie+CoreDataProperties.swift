//
//  Movie+CoreDataProperties.swift
//  MovieReleaseDateApp
//
//  Created by Jason Bannister on 14/09/2021.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var id: Int32
    @NSManaged public var isFavourite: Bool
    @NSManaged public var original_language: String?
    @NSManaged public var original_title: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Int16
    @NSManaged public var poster_path: String?
    @NSManaged public var release_date: String?
    @NSManaged public var title: String?
    @NSManaged public var vote_average: Int16
    
    public var wrappedOriginal_language: String { original_language ?? "Unknown" }
    public var wrappedOriginal_title: String { original_title ?? "Unknown" }
    public var wrappedOverview: String { overview ?? "No overview found"}
    public var wrappedPoster_Path: String { poster_path ?? "https://i.etsystatic.com/10919371/r/il/edc333/1841844492/il_1588xN.1841844492_lo2o.jpg" }
    public var wrappedRelease_Date: String { release_date ?? "No release date found" }
    public var wrappedTitle: String { title ?? "No title found" }

}

extension Movie : Identifiable {

}
