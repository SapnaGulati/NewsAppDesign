//
//  FrontScreenViewController.swift
//  NewsApp
//
//  Created by ios4 on 13/05/21.
//

import UIKit
import GoogleSignIn
//import FBSDKLoginKit
//import FBSDKCoreKit
import AuthenticationServices

class LogInViewController: UIViewController, GIDSignInDelegate {
    
    // MARK: Outlet
    
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var continueLabel: UILabel!
    let defaults = UserDefaults.standard
    var googleLogIn: Bool?
    var facebookLogIn: Bool?
    var username: UITextField!
    var password: UITextField!
    
    // MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupFonts()
        preferredStatusBarStyle.setupStatusBar(string: "#ffffff")
        GIDSignIn.sharedInstance()?.delegate = self
        defaults.set(false, forKey: "googleLogIn")
        defaults.set(false, forKey: "facebookLogIn")
//        let tap = UITapGestureRecognizer(target: self, action: #selector(LogInViewController.tapFunction))
//        continueLabel.isUserInteractionEnabled = true
//        continueLabel.addGestureRecognizer(tap)
    }
    
    // MARK: Set up Fonts
    private func setupFonts() {
        continueLabel.font = UIFont(name: "Poppins-SemiBold", size: 20)
        continueLabel.textColor = UIColor(hexString: "#c4272b")
        underlineView.backgroundColor = UIColor(hexString: "#c4272b")
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "loginScreenVC") as! loginScreenVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Button Action
    @IBAction func facebookButton(_ sender: UIButton) {
//        facebookLogIn = defaults.bool(forKey: "facebookLogIn")
//        if (GIDSignIn.sharedInstance().hasPreviousSignIn() || facebookLogIn!) {
//            gotoCountryVC()
//        }
//        else {
//            facebookLogin()
//        }
        gotoCountryVC()
    }
    
    @IBAction func googleButton(_ sender: UIButton) {
//        googleLogIn = defaults.bool(forKey: "googleLogIn")
//        facebookLogIn = defaults.bool(forKey: "facebookLogIn")
//        GIDSignIn.sharedInstance()?.presentingViewController = self
//        if (facebookLogIn!) {
//            gotoCountryVC()
//        }
//        else {
//            if GIDSignIn.sharedInstance().hasPreviousSignIn(){
//                GIDSignIn.sharedInstance()?.restorePreviousSignIn()
//            }
//            else {
//                GIDSignIn.sharedInstance()?.signIn()
//            }
//        }
        gotoCountryVC()
    }
    
    @IBAction func appleButton(_ sender: UIButton) {
//        googleLogIn = defaults.bool(forKey: "googleLogIn")
//        facebookLogIn = defaults.bool(forKey: "facebookLogIn")
//        if (GIDSignIn.sharedInstance().hasPreviousSignIn() || facebookLogIn!) {
//            gotoCountryVC()
//        }
//        else {
//            let appleIDProvider = ASAuthorizationAppleIDProvider()
//            let request = appleIDProvider.createRequest()
//            request.requestedScopes = [.fullName, .email]
//            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//            authorizationController.delegate = self
//            authorizationController.presentationContextProvider = self
//            authorizationController.performRequests()
//        }
        gotoCountryVC()
    }
  
    // MARK: Google Sign In Delegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            defaults.set(true, forKey: "googleLogIn")
            print(user.userID!)
            gotoCountryVC()
        }
    }
    /*
    func facebookLogin(){
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile], viewController: self) { (result) in
            switch result {
            case .success:
                self.defaults.set(true, forKey: "facebookLogIn")
                if let token = AccessToken.current,
                !token.isExpired {
                    let token = token.tokenString
                    let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name, picture, short_name, name, middle_name, name_format,age_range"], tokenString: token, version: nil, httpMethod: .get)
                    request.start { (connection, result, error) in
                    print("\(String(describing: result))")
                    self.gotoCountryVC()
                    }
                }
            case .cancelled:
                return
            case .failed(_):
                return
            }
        }
    }*/
    
    func gotoCountryVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SelectCountryViewController") as! SelectCountryViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: Extension for UIColor
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
/*
extension LogInViewController: LoginButtonDelegate{
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name, picture, short_name, name, middle_name, name_format,age_range"], tokenString: token, version: nil, httpMethod: .get)
        request.start { (connection, result, error) in
            print("\(String(describing: result))")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logout")
    }
}

extension LogInViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIdCred = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let appleIdToken = appleIdCred.identityToken else {
                print("Something went wrong")
                return
            }
            
            guard String(data: appleIdToken, encoding: .utf8) != nil else {
                print("Can't convert to string")
                return
            }
            
            print(appleIdCred.fullName?.givenName ?? "")
            print(appleIdCred.fullName?.familyName ?? "")
            print(appleIdCred.email ?? "")
        }
        defaults.set(true, forKey: "appleLogIn")
        gotoCountryVC()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error.localizedDescription)
    }
}
*/
