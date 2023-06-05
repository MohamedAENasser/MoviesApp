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
    private var movieID: String
    private var service: MovieDetailsServiceProtocol
    @Published var detailsModel: MovieDetails?

    init(movieID: String, service: MovieDetailsServiceProtocol = MovieDetailsService()) {
        self.service = service
        self.movieID = movieID
    }

    func loadDetails() {
        Task {
            let result = await service.getMovieDetails(id: movieID)
            switch result {
            case .success(let model):
                detailsModel = model
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
}
