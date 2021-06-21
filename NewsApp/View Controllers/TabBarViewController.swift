//
//  TabBarViewController.swift
//  NewsApp
//
//  Created by ios4 on 17/05/21.
//

import UIKit

class TabBarViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var homeImageIcon: UIImageView!
    @IBOutlet weak var settingsImageIcon: UIImageView!
    @IBOutlet weak var customTabStackView: UIStackView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    // MARK: Variables
    private var firstVC: UIViewController?
    private var openHome: Bool = false
    private var openSettings: Bool = false
    
    // MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        setupNavigationBarItems()
        customTabStackView.layer.cornerRadius = 20
        customTabStackView.clipsToBounds = true
        customTabStackView.layer.borderWidth = 2
        customTabStackView.layer.borderColor = UIColor(hexString: "#e8e8e8").cgColor
        homeButton.layer.borderWidth = 1
        homeButton.layer.borderColor = UIColor(hexString: "#b80d00").cgColor
        settingsButton.layer.borderWidth = 1
        settingsButton.layer.borderColor = UIColor(hexString: "#b80d00").cgColor
    }
    
    // MARK: Button Actions
    @IBAction func homeButton(_ sender: Any)
    {
        homeImageIcon.isHighlighted = true
        settingsImageIcon.isHighlighted = false
        homeButton.isEnabled = false
        settingsButton.isEnabled = true
        
        if(openSettings){
            let oldVC = self.storyboard!.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
            let newVC = self.storyboard!.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            hide(oldVC)
            display(newVC)
            openHome = true
            openSettings = false
        }
        else {
            let oldVC = children.first!
            let newVC = self.storyboard!.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            cycle(from: oldVC, to: newVC)
            openHome = true
            openSettings = false
        }
    }

    @IBAction func settingsButton(_ sender: UIButton) {
        settingsButton.isEnabled = false
        homeButton.isEnabled = true
        settingsImageIcon.isHighlighted = true
        homeImageIcon.isHighlighted = false
        
        if(openHome){
            let oldVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            let newVC = self.storyboard!.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
            hide(oldVC)
            display(newVC)
            openSettings = true
            openHome = false
        }
        else {
            openSettings = true
            openHome = false
            let oldVC = children.first!
            let newVC = self.storyboard!.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
            cycle(from: oldVC, to: newVC)
        }
    }

    // MARK: Handling Child View Transition in Container View
    private func cycle(from oldVC: UIViewController, to newVC: UIViewController) {
        oldVC.willMove(toParent: nil)
        addChild(newVC)
        newVC.view.frame = containerView.bounds

        transition(from: oldVC, to: newVC, duration: 0.25, options: .transitionCrossDissolve, animations: {
        }, completion: { finished in
            oldVC.removeFromParent()
            newVC.didMove(toParent: self)
        })
    }

    private func display(_ child: UIViewController) {
        addChild(child)
        child.view.frame = containerView.bounds
        containerView.addSubview(child.view)
        child.didMove(toParent: self)
    }

    private func hide(_ child: UIViewController) {
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
    
    // MARK: Initial Segue Handling
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoHome" {
            firstVC = segue.destination as! HomeViewController
            self.addChild(firstVC!)
            self.view.addSubview(firstVC!.view)
            self.didMove(toParent: self)
            homeImageIcon.isHighlighted = true
            settingsImageIcon.isHighlighted = false
        }
    }
    
    // MARK: Custom Navigation Bar
    private func setupNavigationBarItems() {
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.backgroundColor = .systemBackground
        }
        let titleText = UILabel()
        titleText.text = "Home"
        titleText.font = UIFont(name: "Poppins-Medium", size: 21)
        titleText.textColor = UIColor(hexString: "#b80d00")
        titleText.frame = CGRect(x:0, y: 0, width: 50, height: 34)
        navigationItem.titleView = titleText
        
        let filterButton = UIButton(type: .system)
        filterButton.setImage(UIImage(named: "filter")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: UIControl.State.normal)
        filterButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: filterButton)
        filterButton.addTarget(self, action: #selector(gotoFilter), for: .touchUpInside)
        
        let searchButton = UIButton(type: .system)
        searchButton.setImage(UIImage(named: "search")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: UIControl.State.normal)
        searchButton.frame = CGRect(x: 0, y:0, width: 34, height: 34)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
        searchButton.addTarget(self, action: #selector(gotoSearch), for: .touchUpInside)
    }
    
    @objc func gotoFilter() {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func gotoSearch() {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "SearchTableViewController") as! SearchTableViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
