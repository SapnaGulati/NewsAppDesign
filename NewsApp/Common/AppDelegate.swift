//
//  AppDelegate.swift
//  NewsApp
//
//  Created by ios4 on 13/05/21.
//

import UIKit
import CoreData
import GoogleSignIn
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigationController = UINavigationController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Thread.sleep(forTimeInterval: 3.0)
        GIDSignIn.sharedInstance().clientID = "224073299943-v0j0ijecqeroero43rpmqqved6rausmm.apps.googleusercontent.com"
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        navigateToLogin()
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(
        app,
        open: url,
        sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
        annotation: options[UIApplication.OpenURLOptionsKey.annotation]
      )
        return (GIDSignIn.sharedInstance()?.handle(url))!
    }
    
    @objc func navigateToLogin() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if DataManager.loginStatus{
            if (DataManager.selectedCategory == nil && DataManager.selectedCountry == nil){
                let countryvc = storyboard.instantiateViewController(withIdentifier: "SelectCountryViewController") as! SelectCountryViewController
                self.navigationController = UINavigationController(rootViewController: countryvc)
            }
            else if (DataManager.selectedCategory == nil){
                let categoryvc = storyboard.instantiateViewController(withIdentifier: "SelectCategoryViewController") as! SelectCategoryViewController
                self.navigationController = UINavigationController(rootViewController: categoryvc)
            }
            else{
                let tabvc = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                self.navigationController = UINavigationController(rootViewController: tabvc)
            }
        }
        else{
            let loginvc = storyboard.instantiateViewController(withIdentifier: "LogInViewController") as! LogInViewController
            self.navigationController = UINavigationController(rootViewController: loginvc)
        }
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
}
