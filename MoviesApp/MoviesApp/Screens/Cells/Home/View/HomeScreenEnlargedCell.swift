//
//  HomeScreenEnlargedCell.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 03/06/2023.
//

import UIKit
import Combine

class HomeScreenEnlargedCell: UICollectionViewCell, NibLoadableView {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    var viewModel: HomeScreenCellViewModel?

    override func prepareForReuse() {
        super.prepareForReuse()

        movieImageView.image = nil
    }

    func configure(with model: Movie) {
        viewModel = HomeScreenCellViewModel(model: model)
        setupBindings()
        guard let viewModel else { return }

        viewModel.requestImage()
        titleLabel.text = viewModel.getTitle()
        originalTitleLabel.text = viewModel.getOriginalTitle()
        releaseDateLabel.text = viewModel.getReleaseDate()
        ratingLabel.text = viewModel.getRating()
        overviewLabel.text = viewModel.getOverview()
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
