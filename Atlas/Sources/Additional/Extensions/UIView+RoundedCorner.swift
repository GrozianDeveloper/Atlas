//
//  UIView+RoundedCorner.swift
//  Atlas
//
//  Created by Bogdan Grozian on 14.07.2021.
//

import UIKit

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
extension UIView {
    static func loadFromXib<T>(withOwner: Any? = nil, options: [UINib.OptionsKey : Any]? = nil) -> T where T: UIView
    {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: "\(self)", bundle: bundle)

        guard let view = nib.instantiate(withOwner: withOwner, options: options).first as? T else {
            fatalError("Could not load view from nib file.")
        }
        return view
    }
}
