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
    case movieDetails(_ id: String)
}

extension MoviesTarget: TargetType {
    var baseURL: URL {
        switch self {

        case .moviesList:
            return URL(string: "https://api.themoviedb.org/3/discover")!

        case .configuration:
            return URL(string: "https://api.themoviedb.org/3/configuration")!

        case .movieDetails:
            return URL(string: "https://api.themoviedb.org/3/movie")!
        }
    }

    var path: String {
        switch self {

        case .moviesList:
            return "/movie"

        case .configuration:
            return ""

        case .movieDetails(let id):
            return "/\(id)"
        }
    }

    var method: Moya.Method {
        switch self {

        default:
            return .get

        }
    }

    var task: Moya.Task {
        var parameters: [String: Any] = [
            "api_key" : MoviesTarget.apiKey
        ]
        switch self {

        case .moviesList:
            // TODO: pages handling
        default:
            break

        }

        return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
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
