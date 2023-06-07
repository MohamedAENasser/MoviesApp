//
//  HomeScreenCompactShimmerCell.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 07/06/2023.
//

import UIKit

class HomeScreenCompactShimmerCell: UICollectionViewCell, NibLoadableView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet var shimmerViews: [ShimmerView]!

    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.layer.cornerRadius = 6
        shimmerViews.forEach { $0.startAnimating() }
    }
}
