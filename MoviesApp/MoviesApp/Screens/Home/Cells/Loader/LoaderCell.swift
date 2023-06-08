//
//  LoaderCell.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 06/06/2023.
//

import UIKit

class LoaderCell: UICollectionViewCell {

    var indicator : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        return view
    }()

    override func prepareForReuse() {
        super.prepareForReuse()

        indicator.startAnimating()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonSetup()
    }

    private func commonSetup(){
        setupViews()
        setupLayout()
    }

    private func setupViews() {
        contentView.addSubview(indicator)
        indicator.startAnimating()
    }

    private func setupLayout() {
        indicator.center = contentView.center
    }
}
