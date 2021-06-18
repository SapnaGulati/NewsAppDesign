//
//  CustomAlert.swift
//  QUTELINKS
//
//  Created by ios on 24/04/18.
//  Copyright © 2018 ios. All rights reserved.
//

import UIKit
import FloatRatingView

typealias ButtonAction = (()->())
typealias RatingAction = ((Double, String?)->())
var ispurchasePopUp = false

var enteredNumb = 0

class CustomAlert: UIView {
    
    //MARK: IBOutlets
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var view: UIView!
    @IBOutlet var popUpView: UIView!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var ratingView: FloatRatingView!
    @IBOutlet weak var backgroundButton: UIButton!
    @IBOutlet weak var tickImageHeight: NSLayoutConstraint!
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    //MARK: Setup
    convenience init(title:String?, message: String?, cancelButtonTitle: String? = nil, doneButtonTitle: String = "Okay", isRating: Bool = false,showImage:Bool = true,showTF:Bool = true) {
        
        self.init(frame: UIScreen.main.bounds)
        self.initialize(title:title, message: message, cancelButtonTitle: cancelButtonTitle, doneButtonTitle: doneButtonTitle, isRating: isRating,showImage: showImage,textFieldShow: showTF)
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
    
    //MARK: Private Methods
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
    
    private func initialize(title:String?, message: String?, cancelButtonTitle: String? = nil, doneButtonTitle: String = "Okay", isRating: Bool = false,showImage:Bool = true,textFieldShow: Bool = true) {
//        textField.set(radius: 0, borderColor: UIColor.darkGray, borderWidth: 1)
        //doneButton.set(radius: 9)
//        doneButton.dropShadow()
       // cancelButton.set(radius: 9)
//        cancelButton.dropShadow()
        self.titleLabel.text = title
        let attributedString = NSMutableAttributedString(string: message ?? "")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0.5 // Whatever line spacing you want in points
        paragraphStyle.alignment = .center
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        self.messageLabel.attributedText = attributedString
        self.doneButton.setTitle(doneButtonTitle, for: .normal)
        self.titleLabel.isHidden = title == nil
        self.messageLabel.isHidden = message == nil
        self.cancelButton.isHidden = cancelButtonTitle == nil
        self.cancelButton.setTitle(cancelButtonTitle, for: .normal)
        backgroundButton.isHidden = true
        rateView.isHidden = !isRating
        if !showImage{
           // topConstraint.constant = 0
            tickImageHeight.constant = 0
        }
        
        if isRating {
            //self.topConstraint.constant = 0.0
        }
        textField.isHidden = textFieldShow
    }
    //MARK: Show Alert
    func show() {
        self.alpha = 0
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1.0
        }
    }
    
    func remove() {
        UIApplication.shared.keyWindow?.addSubview(self)
        UIView.animate(withDuration: 0.2, delay: 0.0, animations: {
            self.alpha = 0
        }, completion: {(success) in
            self.removeFromSuperview()
        })
    }

    @IBAction func textFieldDidEditingChangedAction(_ sender: UITextField) {
        if let numb = Int(sender.text!){
            enteredNumb = numb
        }
    }
    
    //MARK: IBActions
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.remove()
    }
    
    @IBAction func doneButtonAction(_ sender: UIButton) {
        self.remove()
    }
}

//For Handle Action
class ClosureSleeve {
    let closure: ()->()
    
    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }
    
    @objc func invoke () {
        closure()
    }
}

//Add Target With Closure
extension UIControl {
    func addTarget (action: @escaping ()->()) {
        let sleeve = ClosureSleeve(action)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: .touchUpInside)
        objc_setAssociatedObject(self, String(ObjectIdentifier(self).hashValue) + String(UIControl.Event.touchUpInside.rawValue), sleeve,
                                 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}

extension UIApplication {
    
    class func getTopViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
            
        } else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        return base
    }
}
