//
//  Movie.swift
//  Movie
//
//  Created by Alex Serhiiev on 08.03.2023.
//

import Foundation

// MARK: - Result
struct Result: Codable {
    let page: Int
    let results: [ResultElement]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - ResultElement
class ResultElement: Codable {
    
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let title: String?
    let name: String?
    let originalLanguage: String
    let originalName: String?
    let originalTitle: String?
    var overview, posterPath: String
    let mediaType: MediaType?
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String?
    let firstAirDate: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
    let originCountry: [String]?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title, name
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originCountry = "origin_country"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case ko = "ko"
    case fr = "fr"
    case ja = "ja"
    case zh = "zh"
    case es = "es"
}
