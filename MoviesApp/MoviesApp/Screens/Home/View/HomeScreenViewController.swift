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

    var viewModel: HomeScreenViewModel = HomeScreenViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        registerCells()
        setupBindings()
        getMovies()
    }

    private func setupUI() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
    }

    private func registerCells() {
        collectionView.register(HomeScreenEnlargedCell.self)
        collectionView.register(HomeScreenEnlargedShimmerCell.self)
        collectionView.register(HomeScreenErrorCell.self)
        collectionView.register(LoadingCell.self)
    }

    private func getMovies() {
        Task {
            await viewModel.getMovies()
        }
    }

    private func setupBindings() {
        viewModel.$status.subscribe(Subscribers.Sink(
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
