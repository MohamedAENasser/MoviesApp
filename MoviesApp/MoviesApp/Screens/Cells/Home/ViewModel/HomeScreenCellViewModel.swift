//
//  HomeScreenCellViewModel.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 04/06/2023.
//

import UIKit
import Combine

class HomeScreenCellViewModel {
    private var model: Movie
    private var service: HomeScreenServiceProtocol
    private var imageLoader: ImageLoader
    private var imageURLString = ""
    @Published var image: UIImage?

    init(model: Movie, service: HomeScreenServiceProtocol = HomeScreenService(), imageLoader: ImageLoader = ImageLoader()) {
        self.model = model
        self.service = service
        self.imageLoader = imageLoader

        setupBindings()
    }

    func getTitle() -> String {
        model.title
    }

    func getOriginalTitle() -> String {
        if model.originalTitle != model.title && !model.originalTitle.isEmpty {
            return "(Original: \(model.originalTitle))"
        } else {
            return ""
        }
    }

    func getReleaseDate() -> String {
        String(model.releaseDate.prefix(4))
    }

    func getRating() -> String {
        String(model.voteAverage)
    }

    func getOverview() -> String {
        String(model.overview)
    }

    func requestImage() {
        Task {
            let result = await service.getImageURL(at: model.posterPath)
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
