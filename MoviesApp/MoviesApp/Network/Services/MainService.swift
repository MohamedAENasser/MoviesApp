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

    func setupConfigurationIfNeeded(resolution: PosterModel.Resoultion) async -> AppError?
    func getImageURL(at path: String, resolution: PosterModel.Resoultion) async -> Result<String, AppError>
}

class MainService: MainServiceProtocol {
    var provider: MoyaProvider<MoviesTarget>

    private static var posterBaseURL: PosterModel?

    init(provider: MoyaProvider<MoviesTarget> = MoyaProvider<MoviesTarget>()) {
        self.provider = provider
    }

    func setupConfigurationIfNeeded(resolution: PosterModel.Resoultion) async -> AppError? {
        return await withCheckedContinuation { continuation in
            guard MainService.posterBaseURL == nil else {
                return continuation.resume(returning: nil)
            }

            provider.request(.configuration) { result in

                switch result {

                case .success(let response):
                    do {
                        let configurationModel = try response.map(ConfigurationModel.self)
                        let originalPath = configurationModel.images.posterSizes?.last ?? "original"
                        MainService.posterBaseURL = PosterModel(
                            baseURL: configurationModel.images.baseURL ?? "",
                            lowResolutionPath: configurationModel.images.posterSizes?[safe: 2] ?? originalPath,
                            hightResolutionPath: configurationModel.images.posterSizes?[safe: 4] ?? originalPath,
                            originalResolutionPath: originalPath
                        )

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

    func getImageURL(at path: String, resolution: PosterModel.Resoultion) async -> Result<String, AppError> {
        if let error = await setupConfigurationIfNeeded(resolution: resolution) {
            return .failure(error)
        }
        guard let baseURL = MainService.posterBaseURL?.getBaseURL(for: resolution) else {
            return .failure(.failedToLoadData)
        }

        return .success(baseURL.appending(path))
    }
}
