//
//  HomeScreenEnlargedShimmerCell.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 06/06/2023.
//

import UIKit

class HomeScreenEnlargedShimmerCell: UICollectionViewCell, NibLoadableView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var shimmerViews: [ShimmerView]!

    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.layer.cornerRadius = 6
        shimmerViews.forEach { $0.startAnimating() }
    }
}
