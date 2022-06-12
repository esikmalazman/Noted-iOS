//
//  UIView + Extensions.swift
//  Noted
//
//  Created by Ikmal Azman on 12/06/2022.
//

import UIKit.UIView

extension UIView {
    /// Apply linear gradient to current layer of the view
    func applyLinearGradient(color : UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: -0.2)
     
        gradientLayer.colors = [color.cgColor, color.withAlphaComponent(0.6).cgColor]
        
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
