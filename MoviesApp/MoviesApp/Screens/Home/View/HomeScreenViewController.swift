//
//  HomeScreenViewController.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 03/06/2023.
//

import UIKit
import Combine

class HomeScreenViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    let viewModel: HomeScreenViewModel = HomeScreenViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells()
        setupBindings()
        getMovies()
    }

    private func registerCells() {
        collectionView.register(HomeScreenEnlargedCell.self)
    }

    private func getMovies() {
        Task {
            await viewModel.getMovies()
        }
    }
    var count = 0
    private func setupBindings() {
        viewModel.$moviesList.subscribe(Subscribers.Sink(
            receiveCompletion: { _ in },
            receiveValue: { _ in
                self.reloadCollectionData()
            })
        )
    }

    private func reloadCollectionData(index: Int? = nil) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
