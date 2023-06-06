//
//  HomeScreenViewController+CollectionView.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 03/06/2023.
//

import UIKit

extension HomeScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HomeScreenEnlargedCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)

        guard let model = viewModel.movie(at: indexPath.row) else {
            return cell
        }
        cell.configure(with: model)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movieModel = viewModel.movie(at: indexPath.row) else { return }
        let movieDetailsViewController = MovieDetailsViewController(movieModel: movieModel)

        navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }

    // MARK: - Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let space: CGFloat = 16
        let collectionWidth = collectionView.frame.size.width
        return CGSize(width: collectionWidth - space, height: 0)

    }
}
