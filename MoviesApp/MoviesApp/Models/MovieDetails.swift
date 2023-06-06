//
//  MovieDetails.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 06/06/2023.
//

import Foundation

struct MovieDetails: Codable {
    let genres: [Genre]
    let releaseDate: String
    let title: String
    let originalTitle: String?
    let voteAverage: Double
    let overview: String
    let posterPath: String?

    private enum CodingKeys: String, CodingKey {
        case genres, title, overview, posterPath
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }

    struct Genre: Codable {
        let id: Int
        let name: String
    }

}
