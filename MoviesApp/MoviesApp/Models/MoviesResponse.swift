//
//  MoviesResponse.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 02/06/2023.
//

import Foundation

// MARK: - MoviesResponse
struct MoviesResponse: Codable {
    var page: Int?
    var totalPages: Int?
    var totalResults: Int?
    var results: [Movie]

    private enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Movie
struct Movie: Codable {
    var id: Int
    var adult: Bool?
    var backdropPath: String?
    var genreIDs: [Int]?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate: String?
    var title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?

    private enum CodingKeys: String, CodingKey {
        case id, adult, overview, popularity, title, video
        case genreIDs = "genre_ids"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
