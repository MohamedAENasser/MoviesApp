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

        registerCells()
        setupBindings()
        getMovies()
    }

    func registerCells() {
        collectionView.register(HomeScreenEnlargedCell.self)
    }

    func getMovies() {
        Task {
            await viewModel.getMovies()
        }
    }
    func setupBindings() {
        viewModel.$moviesList.subscribe(Subscribers.Sink(
            receiveCompletion: { _ in },
            receiveValue: { result in
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            })
        )
    }
}
