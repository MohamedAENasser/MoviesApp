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
        switch viewModel.status {
        case .loading:
            return getHomeScreenEnlargedShimmerCell(at: indexPath)

        case .success:
            if viewModel.shouldAddLoader(at: indexPath.row) {
                return getLoadingCell(at: indexPath)
            } else {
                return getHomeScreenEnlargedCell(at: indexPath)
            }

        case .error:
            return getHomeScreenErrorCell(at: indexPath)
        }
    }

    private func getHomeScreenErrorCell(at indexPath: IndexPath) -> HomeScreenErrorCell {
        let cell: HomeScreenErrorCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.retryAction = { [weak self] in
            Task {
                await self?.viewModel.getMovies()
            }
        }
        return cell
    }

    private func getHomeScreenEnlargedShimmerCell(at indexPath: IndexPath) -> HomeScreenEnlargedShimmerCell {
        let cell: HomeScreenEnlargedShimmerCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }

    private func getHomeScreenEnlargedCell(at indexPath: IndexPath) -> HomeScreenEnlargedCell {
        let cell: HomeScreenEnlargedCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)

        guard let model = viewModel.movie(at: indexPath.row) else {
            return cell
        }
        cell.configure(with: model)

        return cell
    }

    private func getLoadingCell(at indexPath: IndexPath) -> LoadingCell {
        let loadingCell: LoadingCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        return loadingCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard case .success = viewModel.status,
            let movieModel = viewModel.movie(at: indexPath.row) else { return }
        let movieDetailsViewController = MovieDetailsViewController(movieModel: movieModel)

        navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.shouldAddLoader(at: indexPath.row) {
            Task {
                await viewModel.loadMoreMovies()
            }
        }
    }

    // MARK: - Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let space: CGFloat = 16
        let collectionWidth = collectionView.frame.size.width
        let screenHeight = (view.window?.bounds.height ?? 1000)
        switch viewModel.status {
        case .loading, .success:
            return CGSize(width: collectionWidth - space, height: screenHeight / 6)
        case .error:
            return CGSize(width: collectionWidth - space, height: screenHeight / 2)
        }
    }
}
