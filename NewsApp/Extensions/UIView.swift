//
//  UIView.swift
//  NewsApp
//
//  Created by ios4 on 10/06/21.
//

import UIKit


// MARK: Extension for UITableViewCell Shadow
extension UIView {
    
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                  shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                  shadowOpacity: Float = 0.4,
                  shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}
