//
//  HomeScreenEnlargedCell.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 03/06/2023.
//

import UIKit

class HomeScreenEnlargedCell: UICollectionViewCell, NibLoadableView {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!

    func configure(with model: Movie) {
        // TODO: Load image logic
        titleLabel.text = model.title
        if model.originalTitle != model.title && !model.originalTitle.isEmpty {
            originalTitleLabel.text = "(Original: \(model.originalTitle))"
            originalTitleLabel.isHidden = false
        } else {
            originalTitleLabel.isHidden = true
        }
        releaseDateLabel.text = String(model.releaseDate.prefix(4))
        ratingLabel.text = String(model.voteAverage)
        overviewLabel.text = model.overview
    }
}
