//
//  UIView.swift
//  NewsApp
//
//  Created by ios4 on 10/06/21.
//

import UIKit


// MARK: Extension for UITableViewCell Shadow
extension UIView {
    private struct AssociatedKeys {
        static var emptyView: UIView!
    }
    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
                  shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
                  shadowOpacity: Float = 0.4,
                  shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    func setEmptyData(message: String) {
        AssociatedKeys.emptyView = UIView(frame: CGRect(x: self.center.x/2, y: self.center.y/2, width: self.bounds.size.width/2, height: self.bounds.size.height/2))
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = UIColor.gray
        messageLabel.font = UIFont(name: "Nexa-Bold", size: 17)
        AssociatedKeys.emptyView.addSubview(messageLabel)
        messageLabel.centerYAnchor.constraint(equalTo: AssociatedKeys.emptyView.centerYAnchor).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: AssociatedKeys.emptyView.centerXAnchor).isActive = true
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        self.addSubview(AssociatedKeys.emptyView)
    }
    func restoreView() {
        self.willRemoveSubview(AssociatedKeys.emptyView)
    }
}
