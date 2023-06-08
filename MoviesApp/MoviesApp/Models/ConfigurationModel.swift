//
//  ConfigurationModel.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 04/06/2023.
//

import Foundation

struct ConfigurationModel: Codable {
    let images: ImageModel
    let changeKeys: [String]

    private enum CodingKeys: String, CodingKey {
        case images
        case changeKeys = "change_keys"
    }

    struct ImageModel: Codable {
        let baseURL: String?
        let secureBaseURL: String?
        let backdropSizes: [String]?
        let logoSizes: [String]?
        let posterSizes: [String]?
        let profileSizes: [String]?
        let stillSizes: [String]?
        let changeKeys: [String]?

        private enum CodingKeys: String, CodingKey {
            case baseURL = "base_url"
            case secureBaseURL = "secure_base_url"
            case backdropSizes = "backdrop_sizes"
            case logoSizes = "logo_sizes"
            case posterSizes = "poster_sizes"
            case profileSizes = "profile_sizes"
            case stillSizes = "still_sizes"
            case changeKeys = "change_keys"
        }
    }
}
