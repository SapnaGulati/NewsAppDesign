//
//  CustomAlert.swift
//  Cheston
//
//  Created by Deftsoft on 23/05/19.
//  Copyright © 2019 Deftsoft. All rights reserved.
//

import UIKit

class CustomAlert: UIView {
    
    //MARK:- IBOutlets
    @IBOutlet var view: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    //MARK:- Variables
    
    //MARK:- Setup
    convenience init(title:String?, message: String?,cancelButtonTitle: String?, doneButtonTitle: String?) {
        self.init(frame: UIScreen.main.bounds)
        self.initialize(title: title, message: message, cancelButtonTitle: cancelButtonTitle,doneButtonTitle: doneButtonTitle)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK:- Private Methods
    private func nibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView { //Load View from Nib
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }
    
    private func initialize(title:String?, message: String?,cancelButtonTitle: String?, doneButtonTitle: String?) {
        if cancelButtonTitle == nil {
            cancelButton.isHidden = true
        }
        
        self.doneButton.setTitle(doneButtonTitle, for: .normal)
        self.cancelButton.setTitle(cancelButtonTitle, for: .normal)
        self.titleLabel.text = title
        messageLabel.attributedText = message?.attributedText()
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        remove()
        
    }
    
    
    //MARK:- Show Alert
    func show() {
        self.alpha = 0
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.1) {
            self.alpha = 1.0
        }
    }
    
    func remove() {
        UIView.animate(withDuration: 0.1, animations: {
            self.alpha = 0
        }, completion: {(success) in
            self.removeFromSuperview()
        })
    }
    
}
