//
//  MoviesService.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 02/06/2023.
//

import Foundation
import Moya

protocol MoviesServiceProtocol {
    var provider: MoyaProvider<MoviesTarget> { get set }

    func getMovies() async -> Result<[Movie], AppError>
}

final class MoviesService: MoviesServiceProtocol {
    var provider: MoyaProvider<MoviesTarget>

    init(provider: MoyaProvider<MoviesTarget> = MoyaProvider<MoviesTarget>()) {
        self.provider = provider
    }

    func getMovies() async -> Result<[Movie], AppError> {
        return await withCheckedContinuation { continuation in
            provider.request(.moviesList) { result in

                switch result {

                case .success(let response):
                    do {
                        try continuation.resume(returning: .success(response.map(MoviesResponse.self).results))
                    } catch {
                        return continuation.resume(returning: .failure(.failedToParseData))
                    }

                case .failure:
                    return continuation.resume(returning: .failure(.failedToLoadData))

                }

            }
        }
    }
}
