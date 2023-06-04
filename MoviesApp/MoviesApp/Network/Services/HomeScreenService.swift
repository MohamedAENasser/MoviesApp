//
//  HomeScreenService.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 02/06/2023.
//

import Foundation
import Moya

protocol HomeScreenServiceProtocol: MainServiceProtocol {
    func getMovies() async -> Result<[Movie], AppError>
    func getImageURL(at path: String) async -> Result<String, AppError>
}

final class HomeScreenService: MainService, HomeScreenServiceProtocol {

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

    func getImageURL(at path: String) async -> Result<String, AppError> {
        if let error = await setupConfigurationIfNeeded() {
            return .failure(error)
        }

        return .success(MoviesTarget.imagesBaseURL.appending(path))
    }

}
