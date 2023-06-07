//
//  MovieDetailsShimmerView.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 07/06/2023.
//

import UIKit

class MovieDetailsShimmerView: UIView, NibLoadableView {
    @IBOutlet var shimmerViews: [ShimmerView]!

    override func awakeFromNib() {
        super.awakeFromNib()

        shimmerViews.forEach { $0.startAnimating() }
    }
}
