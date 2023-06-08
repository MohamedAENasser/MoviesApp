//
//  UIViewController+InstantiateFromStrotyboard.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 07/06/2023.
//

import UIKit

extension UIViewController {
    class func instantiateFromStoryboard<T: UIViewController>(storyboardName: String, bundle: Bundle = .main) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: NSStringFromClass(T.classForCoder()).components(separatedBy: ".").last ?? ""))

        return viewController as? T ?? T()
    }
}
