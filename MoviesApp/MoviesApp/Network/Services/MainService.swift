//
//  MainService.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 04/06/2023.
//

import Foundation
import Moya

protocol MainServiceProtocol {
    var provider: MoyaProvider<MoviesTarget> { get set }

    func setupConfigurationIfNeeded() async -> AppError?
    func getImageURL(at path: String) async -> Result<String, AppError>
}

class MainService: MainServiceProtocol {
    var provider: MoyaProvider<MoviesTarget>

    init(provider: MoyaProvider<MoviesTarget> = MoyaProvider<MoviesTarget>()) {
        self.provider = provider
    }

    func setupConfigurationIfNeeded() async -> AppError? {
        return await withCheckedContinuation { continuation in
            guard MoviesTarget.imagesBaseURL.isEmpty else {
                return continuation.resume(returning: nil)
            }

            provider.request(.configuration) { result in

                switch result {

                case .success(let response):
                    do {
                        let configurationModel = try response.map(ConfigurationModel.self)
                        MoviesTarget.imagesBaseURL = (configurationModel.images.baseURL ?? "").appending("original/") // original can be updated with any of provided sizes in `configurationModel.images.posterSizes` if needed
                        return continuation.resume(returning: nil)
                    } catch {
                        return continuation.resume(returning: .failedToParseData)
                    }

                case .failure:
                    return continuation.resume(returning: .failedToLoadData)

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
