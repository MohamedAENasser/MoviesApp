//
//  HomeScreenCellProtocol.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 07/06/2023.
//

import UIKit

protocol HomeScreenCellProtocol: UICollectionViewCell {
    func configure(with model: Movie)
}
