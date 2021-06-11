//
//  LogoutViewController.swift
//  NewsApp
//
//  Created by ios4 on 18/05/21.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit

class LogoutViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var outerView: UIView!
    
    // MARK: Variables
    let defaults = UserDefaults.standard

    // MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupFonts()
        view.isOpaque = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.parent?.navigationController?.navigationBar.barStyle = .black
    }
    
    // MARK: Set Up Fonts
    func setupFonts() {
        outerView.layer.borderWidth = 2
        outerView.layer.borderColor = UIColor(hexString: "#b80d00").cgColor
        outerView.layer.cornerRadius = 20
        messageLabel.font = UIFont(name: "Poppins-Medium", size: 15)
        messageLabel.textColor = UIColor(hexString: "#333131")
        yesButton.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 15)
        yesButton.titleLabel?.textColor = UIColor(hexString: "#ffffff")
        yesButton.backgroundColor = UIColor(hexString: "#bd1002")
        noButton.backgroundColor = UIColor(hexString: "#2bc812")
        noButton.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 15)
        noButton.titleLabel?.textColor = UIColor(hexString: "#ffffff")
        yesButton.layer.cornerRadius = 7
        noButton.layer.cornerRadius = 7
    }
    
    // MARK: Button Actions
    @IBAction func noButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func yesButtonTapped(_ sender: UIButton) {
        let googleLogIn = defaults.bool(forKey: "googleLogIn")
        let facebookLogIn = defaults.bool(forKey: "facebookLogIn")
        if(googleLogIn) {
            GIDSignIn.sharedInstance()?.signOut()
        }
        else if(facebookLogIn) {
            let fbLoginManager = LoginManager()
            fbLoginManager.logOut()
        }
        else {
            let preferences = UserDefaults.standard
            preferences.removeObject(forKey: "session")
        }
        gotoLogIn()
    }
    
    func gotoLogIn() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "googleLogIn")
        defaults.removeObject(forKey: "facebookLogIn")
        defaults.synchronize()
        self.show(self.storyboard!.instantiateViewController(withIdentifier: "LogInViewController"), sender: self)
    }
}
