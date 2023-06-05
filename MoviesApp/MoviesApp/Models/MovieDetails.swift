//
//  MovieDetails.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 06/06/2023.
//

import Foundation

struct MovieDetails: Codable {
    var genres: [Genre]
    var releaseDate: String
    var title: String
    var voteAverage: Double
    var overview: String

    private enum CodingKeys: String, CodingKey {
        case genres, title, overview
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }

    struct Genre: Codable {
        let id: Int
        let name: String
    }

}
