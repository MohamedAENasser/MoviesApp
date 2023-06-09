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
    private var imageLoader: ImageLoaderProtocol
    private var imageURLString = ""
    @Published var image: UIImage?

    init(model: Movie, service: HomeScreenServiceProtocol = HomeScreenService(), imageLoader: ImageLoaderProtocol = ImageLoader()) {
        self.model = model
        self.service = service
        self.imageLoader = imageLoader

        setupBindings()
    }

    func getTitle() -> String {
        model.title ?? ""
    }

    func getReleaseDate() -> String {
        String(model.releaseDate?.prefix(4) ?? "")
    }

    func getRating() -> String {
        String(model.voteAverage ?? 0)
    }

    func requestImage() {
        guard let path = model.posterPath else { return }
        Task {
            let result = await service.getImageURL(at: path, resolution: .low)
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
            guard let self = self else { return }
            guard urlString == self.imageURLString, self.image == nil else { return }
            self.image = self.imageLoader.getImage(urlString: self.imageURLString)
        }
    }
}
