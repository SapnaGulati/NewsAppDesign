//
//  FrontScreenViewController.swift
//  NewsApp
//
//  Created by ios4 on 13/05/21.
//

import UIKit
import CoreData
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import AuthenticationServices

class LogInViewController: BaseVC, GIDSignInDelegate {
    
    // MARK: Outlet
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var continueLabel: UILabel!
    @IBOutlet weak var appleButton: UIButton!
    
    // MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupFonts()
        preferredStatusBarStyle.setupStatusBar(string: "#ffffff")
        GIDSignIn.sharedInstance()?.delegate = self
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = UIColor.systemBackground
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)
        }
        else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = .none
            appleButton.removeFromSuperview()
        }
    }
    
    // MARK: Set up Fonts
    private func setupFonts() {
        continueLabel.font = UIFont(name: "Poppins-SemiBold", size: 20)
        continueLabel.textColor = UIColor(hexString: "#c4272b")
        underlineView.backgroundColor = UIColor(hexString: "#c4272b")
    }
    
    // MARK: Button Action
    @IBAction func facebookButton(_ sender: UIButton) {
        facebookLogin()
    }
    
    @IBAction func googleButton(_ sender: UIButton) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        if GIDSignIn.sharedInstance().hasPreviousSignIn(){
            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        }
        else {
            GIDSignIn.sharedInstance()?.signIn()
        }
    }
    
    @IBAction func appleButton(_ sender: UIButton) {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }
    }
  
    // MARK: Google Sign In Delegate
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            DataManager.loginStatus = true
            DataManager.googleLogIn = true
            DataManager.userId = user.userID
            createUser()
            if DataManager.selectedCountry == nil && DataManager.selectedCategory == nil {
                gotoCountryVC()
            }
            else if DataManager.selectedCategory == nil {
                gotoCategoryVC()
            }
            else {
                gotoHomeVC()
            }
        }
    }
    
    func facebookLogin(){
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile], viewController: self) { (result) in
            switch result {
            case .success:
                if let token = AccessToken.current,
                !token.isExpired {
                    let token = token.tokenString
                    let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "id, email, first_name, last_name, picture, short_name, name, middle_name, name_format,age_range"], tokenString: token, version: nil, httpMethod: .get)
                    request.start { (connection, result, error) in
                        DataManager.loginStatus = true
                        DataManager.facebookLogIn = true
                        let userData = result as? [String:AnyObject]
                        DataManager.userId = userData?["id"] as? String
                        self.createUser()
                        if DataManager.selectedCountry == nil && DataManager.selectedCategory == nil {
                            self.gotoCountryVC()
                        }
                        else if DataManager.selectedCategory == nil {
                            self.gotoCategoryVC()
                        }
                        else {
                            self.gotoHomeVC()
                        }
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
        vc.comeFrom = .LogIn
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoCategoryVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SelectCategoryViewController") as! SelectCategoryViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoHomeVC() {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
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
        if DataManager.selectedCountry == nil && DataManager.selectedCategory == nil {
            gotoCountryVC()
        }
        else if DataManager.selectedCategory == nil {
            gotoCategoryVC()
        }
        else {
            gotoHomeVC()
        }
        DataManager.loginStatus = true
        DataManager.appleLogIn = true
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
    }
}

extension LogInViewController {
    func createUser() {
        let user = Users(context: PersistentStorage.shared.context)
        user.userId = DataManager.userId
        user.selectedCategory = DataManager.selectedCategory
        user.selectedCountry = DataManager.selectedCountry
        PersistentStorage.shared.saveContext()
    }

    func fetchUser() {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        debugPrint(path[0])
        
        do {
            guard let result = try PersistentStorage.shared.context.fetch(Users.fetchRequest()) as? [Users] else {return}
            result.forEach({debugPrint(($0.userId ?? "") as String)})
        } catch let error
        {
            debugPrint(error)
        }
    }
}
