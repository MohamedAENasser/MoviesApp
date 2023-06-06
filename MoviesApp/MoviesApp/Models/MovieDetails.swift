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
    let voteAverage: Double
    let overview: String
    let posterPath: String?

    private enum CodingKeys: String, CodingKey {
        case genres, title, overview, posterPath
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }

    struct Genre: Codable {
        let id: Int
        let name: String
    }

}
