//
//  MovieDetailsViewModel.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 06/06/2023.
//

import Foundation
import Combine
import UIKit

class MovieDetailsViewModel {
    private var movieModel: Movie
    private var service: MovieDetailsServiceProtocol
    private var imageLoader: ImageLoaderProtocol
    private var imageURLString = ""
    private var detailsModel: MovieDetails?
    @Published  var status: AppStatus<MovieDetails> = .loading
    @Published var image: UIImage?

    init(movieModel: Movie, service: MovieDetailsServiceProtocol = MovieDetailsService(), imageLoader: ImageLoaderProtocol = ImageLoader()) {
        self.movieModel = movieModel
        self.service = service
        self.imageLoader = imageLoader

        setupBindings()
    }

    func loadDetails() {
        status = .loading
        Task {
            let result = await service.getMovieDetails(id: String(movieModel.id))
            switch result {
            case .success(let model):
                detailsModel = model
                status = .success(model)
                requestImage(resolution: .original)
            case .failure:
                status = .error
            }
        }
    }

    func getTitle() -> String {
        detailsModel?.title ?? ""
    }

    func getOriginalTitle() -> String? {
        guard let originalTitle = detailsModel?.originalTitle,
            !originalTitle.isEmpty,
            originalTitle != detailsModel?.title else {
                return nil
        }

        return "(Original: \(originalTitle))"
    }

    func getOverview() -> String {
        detailsModel?.overview ?? ""
    }

    func getRating() -> String {
        String(format: "%.1f", detailsModel?.voteAverage ?? 0)
    }

    func getReleaseData() -> String {
        String(detailsModel?.releaseDate.prefix(4) ?? "")
    }

    func getGenres() -> [MovieDetails.Genre] {
        Array(detailsModel?.genres.prefix(3) ?? [])
    }

    func requestImage(resolution: PosterModel.Resoultion) {
        Task {
            guard let path = movieModel.posterPath else { return }
            let result = await service.getImageURL(at: path, resolution: resolution)
            switch result {
            case .success(let urlString):
                imageURLString = urlString
                image = imageLoader.getImage(urlString: imageURLString)
            case .failure:
                image = UIImage(named: "no-thumbnail")
            }
        }
    }

    private func setupBindings() {
        imageLoader.didUpdateImagesList = { [weak self] urlString in
            guard let self = self, urlString == self.imageURLString, self.image == nil else { return }
            image = imageLoader.getImage(urlString: imageURLString)
        }
    }
}
