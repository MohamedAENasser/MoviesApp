//
//  ShimmerView.swift
//  MoviesApp
//
//  Created by Mohamed Abd ElNasser on 06/06/2023.
//

import UIKit

class ShimmerView: UIView {
    var firstGradientColor : CGColor = UIColor(white: 0.65, alpha: 1).cgColor
    var secondGradientColor : CGColor = UIColor(white: 0.75, alpha: 1).cgColor

    let gradientLayer = CAGradientLayer()

    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)

        gradientLayer.frame = bounds
    }

    func addGradientLayer() -> CAGradientLayer {
        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [firstGradientColor, secondGradientColor, firstGradientColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        layer.addSublayer(gradientLayer)

        return gradientLayer
    }

    func addAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 0.9
        return animation
    }

    func startAnimating() {
        gradientLayer.masksToBounds = true

        let gradientLayer = addGradientLayer()
        let animation = addAnimation()

        gradientLayer.add(animation, forKey: animation.keyPath)
    }

    func stopAnimation() {
        gradientLayer.removeAllAnimations()
    }
}
