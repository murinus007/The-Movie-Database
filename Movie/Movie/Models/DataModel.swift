//
//  DataModel.swift
//  Movie
//
//  Created by Alex Serhiiev on 22.03.2023.
//

import Foundation
import RealmSwift

class DataModel: Object {
    @Persisted var posterPath: String
    @Persisted var overview: String
    @Persisted var name: String
    @Persisted var firstAirDate: String
    @Persisted var voteAverage: String
    @Persisted(primaryKey: true) var id: Int
    
    convenience init(element: ResultElement) {
        self.init()
        posterPath = element.posterPath
        overview = element.overview
        name = element.name ?? element.title ?? ""
        firstAirDate = element.firstAirDate ?? element.releaseDate ?? ""
        voteAverage = String(Double(round(element.voteAverage * 10) / 10))
        id = element.id
    }
}

