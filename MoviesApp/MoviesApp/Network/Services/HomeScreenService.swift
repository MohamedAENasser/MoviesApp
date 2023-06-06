//
//  HomeScreenService.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 02/06/2023.
//

import Foundation
import Moya

protocol HomeScreenServiceProtocol: MainServiceProtocol {
    func getMovies(page: Int) async -> Result<MoviesResponse, AppError>
}

final class HomeScreenService: MainService, HomeScreenServiceProtocol {

    func getMovies(page: Int) async -> Result<MoviesResponse, AppError> {
        return await withCheckedContinuation { continuation in
            provider.request(.moviesList(page)) { result in

                switch result {

                case .success(let response):
                    do {
                        try continuation.resume(returning: .success(response.map(MoviesResponse.self)))
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
