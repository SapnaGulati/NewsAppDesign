//
//  TableViewCell.swift
//  NewsApp
//
//  Created by ios4 on 26/05/21.
//

import UIKit
import SafariServices

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var popupButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var moreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var newsContentView: UIView!
    @IBOutlet weak var newsView: UIView!
    @IBOutlet weak var underlineView: UIView!
    
    var popupclicked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupFonts()
        shareButton.alpha = 0
        bookmarkButton.alpha = 0
        soundButton.alpha = 0
        moreLabel.isUserInteractionEnabled = true
        scrollView.isScrollEnabled = false
        if (scrollView.contentSize.height > newsContentView.frame.size.height) {
            scrollView.isScrollEnabled = true
          }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
    func setupFonts() {
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
        underlineView.backgroundColor = UIColor(hexString: "#c4272b")
    }
}
