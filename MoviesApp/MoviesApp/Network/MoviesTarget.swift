//
//  MoviesTarget.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 02/06/2023.
//

import Moya

enum MoviesTarget {
    static private let apiKey = "API_KEY"

    case moviesList
}

extension MoviesTarget: TargetType {
    var baseURL: URL {
        switch self {

        case .moviesList:
            return URL(string: "https://api.themoviedb.org/3/discover")!

        }
    }

    var path: String {
        switch self {

        case .moviesList:
            return "/movie"

        }
    }

    var method: Moya.Method {
        switch self {

        case .moviesList:
            return .get

        }
    }

    var task: Moya.Task {
        switch self {

        case .moviesList:
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
