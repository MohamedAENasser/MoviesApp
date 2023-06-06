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
    private var imageLoader: ImageLoader
    private var imageURLString = ""
    @Published var detailsModel: MovieDetails?
    @Published var image: UIImage?

    init(movieModel: Movie, service: MovieDetailsServiceProtocol = MovieDetailsService(), imageLoader: ImageLoader = ImageLoader()) {
        self.movieModel = movieModel
        self.service = service
        self.imageLoader = imageLoader

        setupBindings()
    }

    func loadDetails() {
        Task {
            let result = await service.getMovieDetails(id: String(movieModel.id))
            switch result {
            case .success(let model):
                detailsModel = model
                requestImage()
            case .failure:
                break // TODO: Error Handling
            }
        }
    }

    func getTitle() -> String {
        detailsModel?.title ?? ""
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

    func requestImage() {
        Task {
            guard let path = movieModel.posterPath else { return }
            let result = await service.getImageURL(at: path)
            switch result {
            case .success(let urlString):
                imageURLString = urlString
                image = imageLoader.getImage(urlString: imageURLString)
            case .failure:
                break // TODO: Error Handling
            }
        }
    }

    private func setupBindings() {
        imageLoader.didUpdateImagesList = { [weak self] in
            guard let self = self else { return }
            if self.image == nil {
                self.image = self.imageLoader.getImage(urlString: self.imageURLString)
            }
        }
    }
}
