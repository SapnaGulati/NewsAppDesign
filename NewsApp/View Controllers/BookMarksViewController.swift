//
//  BookMarksViewController.swift
//  NewsApp
//
//  Created by ios4 on 18/05/21.
//

import UIKit

class BookMarksViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var popupButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var moreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var imageBGView: UIView!
    
    var popupclicked = false
    
    // MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        setupNavigationBarItems()
        setupFonts()
        imageBGView.addShadow(shadowColor: UIColor.lightGray.cgColor, shadowOffset: CGSize(width: 1, height: 1), shadowOpacity: 0.7, shadowRadius: 3)
        shareButton.alpha = 0
        bookmarkButton.alpha = 0
        soundButton.alpha = 0
    }
    
    // MARK: Button Actions
    @IBAction func popUpButton(_ sender: Any) {
        if(popupclicked == true) {
            self.shareButton.alpha = 0
            self.bookmarkButton.alpha = 0
            self.soundButton.alpha = 0
            self.popupclicked = false
        }
        else {
            self.shareButton.alpha = 1
            self.bookmarkButton.alpha = 1
            self.soundButton.alpha = 1
            self.popupclicked = true
        }
    }
    
    // MARK: Setting up Fonts
    private func setupFonts() {
        titleLabel.font = UIFont(name: "Poppins-SemiBold", size: 20)
        titleLabel.textColor = UIColor(hexString: "#b80d00")
        contentLabel.font = UIFont(name: "Poppins-Regular", size: 15)
        contentLabel.textColor = UIColor(hexString: "#626262")
        contentLabel.lineBreakMode = .byCharWrapping
        moreLabel.font = UIFont(name: "Poppins-Medium", size: 15)
        moreLabel.textColor = UIColor(hexString: "#b80d00")
        dateLabel.font = UIFont(name: "Poppins-Medium", size: 15)
        dateLabel.textColor = UIColor(hexString: "#343333")
        sourceLabel.font = UIFont(name: "Poppins-Medium", size: 17)
        sourceLabel.textColor = UIColor(hexString: "#b80d00")
    }
    
    // MARK: Custom Navigation Bar
    private func setupNavigationBarItems() {
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.backgroundColor = .systemBackground
        }
        let titleText = UILabel()
        titleText.text = "Bookmarks"
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
