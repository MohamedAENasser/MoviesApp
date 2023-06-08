//
//  UIView+LoadFromNib.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 07/06/2023.
//

import UIKit

extension UIView {
    class func loadFromNib<T: NibLoadableView>(bundle: Bundle = .main) -> T {
        bundle.loadNibNamed(T.nibName, owner: nil)?.first as? T ?? T()
    }
}
