//
//  HomeScreenViewModel.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 04/06/2023.
//

import Foundation
import Combine
import UIKit

class HomeScreenViewModel {
    var service: HomeScreenServiceProtocol
    @Published var moviesList: [Movie] = []

    init(service: HomeScreenServiceProtocol = HomeScreenService()) {
        self.service = service
    }

    func getMovies() async {
        let result = await service.getMovies()
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
