//
//  SceneDelegate.swift
//  NewsApp
//
//  Created by ios4 on 13/05/21.
//

import UIKit
import FBSDKCoreKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var navigationController = UINavigationController()

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        navigateToLogin()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {
        PersistentStorage.shared.saveContext()
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

