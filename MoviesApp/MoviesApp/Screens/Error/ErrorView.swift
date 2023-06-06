//
//  ErrorView.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 07/06/2023.
//

import UIKit

class ErrorView: UIView {
    var retryAction: ()->Void = {}

    @IBAction func didTapRetryButton(_ sender: UIButton) {
        retryAction()
    }
}
