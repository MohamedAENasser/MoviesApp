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
    private var totalPages = 3
    private var currentPage = 1
    private var isLoading = false
    private var didReachLastPage: Bool {
        currentPage == totalPages
    }
    private var moviesList: [Movie] = []
    @Published var status: AppStatus<[Movie]> = .loading

    init(service: HomeScreenServiceProtocol = HomeScreenService()) {
        self.service = service
    }

    func getMovies() async {
        let result = await service.getMovies(page: currentPage)
        switch result {
        case .success(let response):
            totalPages = response.totalPages ?? 0
            moviesList.append(contentsOf: response.results)
            status = .success(moviesList)
        case .failure:
            status = .error
        }
        isLoading = false
    }

    func loadMoreMovies() async {
        guard currentPage < totalPages, !isLoading else { return }

        isLoading = true
        currentPage += 1
        await getMovies()
    }

    func numberOfItems() -> Int {
        switch status {

        case .loading:
            return 10

        case .success(let moviesList):
            var moviesCount = moviesList.count
            if currentPage != totalPages { // Adding loading cell if didn't reach latest page
                moviesCount += 1 // The extra one is for loading cell
            }
            return moviesCount

        case .error:
            return 0
        }
    }

    func shouldAddLoader(at index: Int) -> Bool {
        switch status {

        case .loading, .error:
            return false

        case .success(let moviesList):
            guard !didReachLastPage else { return false }
            return index == moviesList.count

        }
    }

    func movie(at index: Int) -> Movie? {
        moviesList[safe: index]
    }
}
