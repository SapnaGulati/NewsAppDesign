//
//  SubscriptionViewController.swift
//  NewsApp
//
//  Created by ios4 on 18/05/21.
//

import UIKit

class SubscriptionViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var restoreLabel: UILabel!
    @IBOutlet weak var weekButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var yearButton: UIButton!
    @IBOutlet weak var underlineView: UIView!

    // MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        setupFonts()
    }
    
    // MARK: Set Up Fonts
    private func setupFonts() {
        contentLabel.font = UIFont(name: "Poppins-Regular", size: 15)
        contentLabel.textColor = UIColor(hexString: "#626262")
        contentLabel.lineBreakMode = .byCharWrapping
        restoreLabel.font = UIFont(name: "Poppins-Medium", size: 15)
        restoreLabel.textColor = UIColor(hexString: "#b80d00")
        underlineView.backgroundColor = UIColor(hexString: "#c4272b")
        weekButton.layer.cornerRadius = 10
        monthButton.layer.cornerRadius = 10
        yearButton.layer.cornerRadius = 10
        weekButton.backgroundColor = UIColor(hexString: "#c01103")
        monthButton.backgroundColor = UIColor(hexString: "#ffbf07")
        yearButton.backgroundColor = UIColor(hexString: "#1dcf09")
        
        weekButton.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 18)
        weekButton.titleLabel?.textColor = UIColor(hexString: "#fefefe")
        monthButton.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 18)
        monthButton.titleLabel?.textColor = UIColor(hexString: "#fefefe")
        yearButton.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 18)
        yearButton.titleLabel?.textColor = UIColor(hexString: "#fefefe")
    }
    
    // MARK: Custom Navigation Bar
    private func setupNavigationBarItems() {
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.backgroundColor = .systemBackground
        }
        let titleText = UILabel()
        titleText.text = "Subscription"
        titleText.font = UIFont(name: "Poppins-Medium", size: 21)
        titleText.textColor = UIColor(hexString: "#b80d00")
        titleText.frame = CGRect(x:0, y: 0, width: 100, height: 34)
        navigationItem.titleView = titleText
        
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "backArrow")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: UIControl.State.normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        backButton.addTarget(self, action: #selector(gotoSettings), for: .touchUpInside)
    }
    
    @objc func gotoSettings() {
        self.navigationController?.popViewController(animated: true)
    }
}
