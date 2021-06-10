//
//  FrontScreenViewController.swift
//  NewsApp
//
//  Created by ios4 on 13/05/21.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
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
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = UIColor.systemBackground
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)
        }
        else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = .none
        }
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
            gotoCountryVC()
//        }
//        else {
//            facebookLogin()
//        }
    }
    
    @IBAction func googleButton(_ sender: UIButton) {
//        googleLogIn = defaults.bool(forKey: "googleLogIn")
//        facebookLogIn = defaults.bool(forKey: "facebookLogIn")
//        GIDSignIn.sharedInstance()?.presentingViewController = self
//        if (facebookLogIn!) {
            gotoCountryVC()
//        }
//        else {
//            if GIDSignIn.sharedInstance().hasPreviousSignIn(){
//                GIDSignIn.sharedInstance()?.restorePreviousSignIn()
//            }
//            else {
//                GIDSignIn.sharedInstance()?.signIn()
//            }
//        }
    }
    
    @IBAction func appleButton(_ sender: UIButton) {
//        googleLogIn = defaults.bool(forKey: "googleLogIn")
//        facebookLogIn = defaults.bool(forKey: "facebookLogIn")
//        if (GIDSignIn.sharedInstance().hasPreviousSignIn() || facebookLogIn!) {
            gotoCountryVC()
//        }
//        else {
//            if #available(iOS 13.0, *) {
//                let appleIDProvider = ASAuthorizationAppleIDProvider()
//                let request = appleIDProvider.createRequest()
//                request.requestedScopes = [.fullName, .email]
//                let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//                authorizationController.delegate = self
//                authorizationController.presentationContextProvider = self
//                authorizationController.performRequests()
//            }
//        }
    }
  
    // MARK: Google Sign In Delegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            defaults.set(true, forKey: "googleLogIn")
            print(user.userID!)
            gotoCountryVC()
        }
    }
    
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
    }
    
    func gotoCountryVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SelectCountryViewController") as! SelectCountryViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

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

@available(iOS 13.0, *)
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
