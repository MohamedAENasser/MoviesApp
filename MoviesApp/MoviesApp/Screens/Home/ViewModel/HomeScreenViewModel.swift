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
    private var service: HomeScreenServiceProtocol
    private var currentPage = 1
    private var isLoading = false
    @Published var moviesList: [Movie] = []

    init(service: HomeScreenServiceProtocol = HomeScreenService()) {
        self.service = service
    }

    func getMovies() async {
        let result = await service.getMovies(page: currentPage)
        switch result {
        case .success(let list):
            moviesList.append(contentsOf: list)
        case .failure:
            break // TODO: Error Handling
        }
        isLoading = false
    }

    func loadMoreMovies() async {
        if isLoading { return }

        isLoading = true
        currentPage += 1
        await getMovies()
    }

    func numberOfItems() -> Int {
        moviesList.count
    }

    func movie(at index: Int) -> Movie? {
        moviesList[safe: index]
    }
}
