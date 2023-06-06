//
//  MovieDetailsShimmerView.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 07/06/2023.
//

import UIKit

class MovieDetailsShimmerView: UIView, NibLoadableView {
    @IBOutlet var shimmerContainerViews: [UIView]!

    override func awakeFromNib() {
        super.awakeFromNib()

        shimmerContainerViews.forEach { view in
            let shimmerView = ShimmerView()
            shimmerView.fill(in: view)

            shimmerView.startAnimating()
        }
    }
}
