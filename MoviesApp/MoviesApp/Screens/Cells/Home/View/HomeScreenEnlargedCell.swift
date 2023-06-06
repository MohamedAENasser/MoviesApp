//
//  HomeScreenEnlargedCell.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 03/06/2023.
//

import UIKit
import Combine

class HomeScreenEnlargedCell: UICollectionViewCell, NibLoadableView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var informationContainerView: UIView!

    var viewModel: HomeScreenCellViewModel?

    override func prepareForReuse() {
        super.prepareForReuse()

        movieImageView.image = nil
    }

    func configure(with model: Movie) {
        viewModel = HomeScreenCellViewModel(model: model)
        setupBindings()
        setupUI()
        guard let viewModel else { return }

        viewModel.requestImage()
        titleLabel.text = viewModel.getTitle()
        releaseDateLabel.text = viewModel.getReleaseDate()
        ratingLabel.text = viewModel.getRating()
    }

    private func setupUI() {
        containerView.layer.cornerRadius = 6
        containerView.layer.shadowOffset = .init(width: 10, height: 10)
    }

    private func setupBindings() {
        viewModel?.$image.subscribe(Subscribers.Sink(
            receiveCompletion: { _ in },
            receiveValue: { image in
                DispatchQueue.main.async {
                    self.movieImageView.image = image
                }
            })
        )
    }
}
