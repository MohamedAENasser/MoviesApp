//
//  HomeScreenViewModel.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 04/06/2023.
//

import Foundation
import Combine

class HomeScreenViewModel {
    var moviesService: MoviesServiceProtocol
    @Published var moviesList: [Movie] = []

    init(moviesService: MoviesServiceProtocol = MoviesService()) {
        self.moviesService = moviesService
    }

    func getMovies() async {
        let result = await moviesService.getMovies()
        switch result {
        case .success(let list):
            moviesList = list
        case .failure:
            break // TODO: Error Handling
        }
    }

    func numberOfItems() -> Int {
        moviesList.count
    }

    func movie(at index: Int) -> Movie? {
        moviesList[safe: index]
    }
}
