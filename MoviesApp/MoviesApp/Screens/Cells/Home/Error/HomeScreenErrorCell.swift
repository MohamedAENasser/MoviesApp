//
//  HomeScreenErrorCell.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 07/06/2023.
//

import UIKit

class HomeScreenErrorCell: UICollectionViewCell, NibLoadableView {
    var retryAction: ()->Void = {}

    @IBAction func didTapRetryButton(_ sender: UIButton) {
        retryAction()
    }
}
