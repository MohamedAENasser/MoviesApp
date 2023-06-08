//
//  MovieDetailsService.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 06/06/2023.
//

import Foundation
import Moya

protocol MovieDetailsServiceProtocol: MainServiceProtocol {
    func getMovieDetails(id: String) async -> Result<MovieDetails, AppError>
}

final class MovieDetailsService: MainService, MovieDetailsServiceProtocol {

    func getMovieDetails(id: String) async -> Result<MovieDetails, AppError> {
        return await withCheckedContinuation { continuation in
            provider.request(.movieDetails(id)) { result in

                switch result {

                case .success(let response):
                    do {
                        try continuation.resume(returning: .success(response.map(MovieDetails.self)))
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
