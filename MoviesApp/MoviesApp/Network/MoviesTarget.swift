//
//  MoviesTarget.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 02/06/2023.
//

import Moya

enum MoviesTarget {
    static private let apiKey = "API_KEY"
    static var imagesBaseURL = ""

    case moviesList
    case configuration
}

extension MoviesTarget: TargetType {
    var baseURL: URL {
        switch self {

        case .moviesList:
            return URL(string: "https://api.themoviedb.org/3/discover")!

        case .configuration:
            return URL(string: "https://api.themoviedb.org/3/configuration")!
        }
    }

    var path: String {
        switch self {

        case .moviesList:
            return "/movie"

        case .configuration:
            return ""
        }
    }

    var method: Moya.Method {
        switch self {

        default:
            return .get

        }
    }

    var task: Moya.Task {
        switch self {

        default:
            return .requestParameters(parameters: [
                "api_key" : MoviesTarget.apiKey
            ], encoding: URLEncoding.queryString)

        }
    }

    var headers: [String : String]? {
        [
            "accept": "application/json",
//            "Authorization": "API_READ_ACCESS_TOKEN" //Authorization is not needed for now as we're using the `api_key` parameter but should be added here just in case its needed for any reason in the future.
        ]
    }

    var sampleData: Data {
       Data()
    }
}
