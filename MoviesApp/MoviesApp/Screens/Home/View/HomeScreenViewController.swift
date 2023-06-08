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
    @IBOutlet weak var viewStylingButton: UIButton!

    var viewModel: HomeScreenViewModel = HomeScreenViewModel()
    var collectionStyle: HomeScreenStyle = .list

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        registerCells()
        setupBindings()
        getMovies()
    }

    @IBAction func viewStyleButtonDidPress(_ sender: UIButton) {
        if collectionStyle == .list {
            collectionStyle = .compact
            viewStylingButton.setImage(UIImage(systemName: HomeScreenStyle.list.iconName), for: .normal)
        } else {
            collectionStyle = .list
            viewStylingButton.setImage(UIImage(systemName: HomeScreenStyle.compact.iconName), for: .normal)
        }
        reloadCollectionData()
    }

    private func setupUI() {
        collectionView.contentInset = UIEdgeInsets(top: 40, left: 20, bottom: 30, right: 20)
        viewStylingButton.setImage(UIImage(systemName: HomeScreenStyle.compact.iconName), for: .normal)
    }

    private func registerCells() {
        // Enlarged
        collectionView.register(HomeScreenEnlargedCell.self)
        collectionView.register(HomeScreenEnlargedShimmerCell.self)

        // Compact
        collectionView.register(HomeScreenCompactCell.self)
        collectionView.register(HomeScreenCompactShimmerCell.self)

        // Loading
        collectionView.register(LoaderCell.self)

        // Error
        collectionView.register(HomeScreenErrorCell.self)
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

    private func reloadCollectionData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
