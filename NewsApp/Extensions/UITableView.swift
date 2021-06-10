//
//  UITableView.swift
//  NewsApp
//
//  Created by ios4 on 10/06/21.
//

import UIKit

// MARK: Extension for empty table view in UITableView
extension UITableView {
    func setEmptyView(message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = UIColor.gray
        messageLabel.font = UIFont(name: "Nexa-Bold", size: 17)
        emptyView.addSubview(messageLabel)
        messageLabel.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 230).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
}
