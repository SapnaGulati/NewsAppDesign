//
//  UIStatusBarStyle.swift
//  NewsApp
//
//  Created by ios4 on 10/06/21.
//

import UIKit

// MARK: Extension for UIStatusBarStyle to change background color
extension UIStatusBarStyle {
    func setupStatusBar(string: String) {
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = UIColor(hexString: "#b80d00")
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)
        }
        else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = UIColor(hexString: "#b80d00")
        }
    }
}
