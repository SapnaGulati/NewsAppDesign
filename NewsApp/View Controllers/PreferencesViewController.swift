//
//  PreferencesViewController.swift
//  NewsApp
//
//  Created by ios4 on 18/05/21.
//

import UIKit

class PreferencesViewController: UIViewController, SelectCountry {
    
    // MARK: Outlets
    private let categories = CategoryList.getCategories()
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var textField: UITextField!
    let defaults = UserDefaults.standard
    var leftIconView: UIImageView!

    // MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        setupCollectionView()
        setupTextField()
        setupFonts()
    }
    
    // MARK: Set Up Fonts
    private func setupFonts() {
        titleLabel.font = UIFont(name: "Poppins-Medium", size: 15)
        titleLabel.textColor = UIColor(hexString: "#b80d00")
        textField.font = UIFont(name: "Poppins-Medium", size: 13)
        textField.textColor = UIColor(hexString: "#302f2f")
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.layer.borderWidth = 2
        textField.tintColor = UIColor(hexString: "#b80d00")
        if #available(iOS 13.0, *) {
            textField.layer.borderColor = UIColor.systemGray6.cgColor
        } else {
            textField.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    // MARK: Text Field Setup
    private func setupTextField() {
        let padding = 28
        let size = 25
        let selectedCountry = self.defaults.string(forKey: "selectedCountry") ?? ""
        self.textField.text = selectedCountry
        let leftImage = UIImage(named: selectedCountry)
        let outerLeftView = UIView(frame: CGRect(x: 0, y: 0, width: size+padding, height: 36))
        let anotherView = UIView(frame: CGRect(x:15, y:3, width: size+6, height: 30))
        leftIconView  = UIImageView(frame: CGRect(x: 3, y: 5, width: size, height: 17))
        anotherView.layer.borderWidth = 0.5
        anotherView.layer.borderColor = UIColor.lightGray.cgColor
        anotherView.layer.cornerRadius = 3.5
        leftIconView.contentMode = .center
        leftIconView.backgroundColor = .white
        leftIconView.image = leftImage
        leftIconView.layer.shadowColor = UIColor.systemGray.cgColor
        leftIconView.layer.shadowOpacity = 0.8
        leftIconView.layer.shadowRadius = 5
        leftIconView.layer.shadowOffset = CGSize(width: 0.5, height: 2)
        outerLeftView.clipsToBounds = true
        outerLeftView.addSubview(anotherView)
        anotherView.addSubview(leftIconView)
        textField.leftView = outerLeftView
        textField.leftViewMode = .always
        let outerRightView = UIView(frame: CGRect(x: 0, y: 0, width: size+padding+12, height: 10))
        let rightIconView  = UIImageView(frame: CGRect(x: padding, y: 0, width: size+12, height: 8))
        let rightImage = UIImage(named: "arrowG")
        rightIconView.contentMode = .center
        rightIconView.image = rightImage
        rightIconView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.arrowTapped(_:)))
        tap.numberOfTapsRequired = 1
        rightIconView.addGestureRecognizer(tap)
        outerRightView.addSubview(rightIconView)
        textField.rightView = outerRightView
        textField.rightViewMode = .always
        textField.layer.cornerRadius = 25.0
        textField.clipsToBounds = true
    }
    
    // MARK: Opening SelectCountryViewController on arrow pressed
    @objc
    func arrowTapped(_ tap: UITapGestureRecognizer) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SelectCountryViewController") as! SelectCountryViewController
        vc.delegate = self
        vc.comeFrom = .Preferences
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Setting choosen name and image
    func setCountry(cName: String) {
        leftIconView.image = UIImage(named: cName)
        textField.text = cName
    }
    
    // MARK: Custom Navigation Bar
    private func setupNavigationBarItems() {
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.backgroundColor = .systemBackground
        }
        let titleText = UILabel()
        titleText.text = "Preferences"
        titleText.font = UIFont(name: "Poppins-Medium", size: 21)
        titleText.textColor = UIColor(hexString: "#b80d00")
        titleText.frame = CGRect(x:0, y: 0, width: 100, height: 34)
        navigationItem.titleView = titleText
        
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "backArrow")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: UIControl.State.normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        backButton.addTarget(self, action: #selector(gotoSettings), for: .touchUpInside)
    }
    
    @objc func gotoSettings() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: Collection View Delegate and Data Source and Flow Layout
extension PreferencesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func setupCollectionView() {
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "cellId")
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: Flow Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 0
            flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 48)/2, height: 145)
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        let cID = defaults.integer(forKey: "cID")
        if indexPath.row == cID {
            cell.isSelected = true
        }
        else {
            cell.isSelected = false
        }
        var image: UIImage!
        if(cell.isSelected) {
            image = UIImage(named: "borderR")
        }
        else {
            image = UIImage(named: "borderG")
        }
        cell.contentView.layer.masksToBounds = true
        let imageView = UIImageView(image: image)
        cell.backgroundView = imageView
        cell.cellLabel.text = categories[indexPath.row].name
        cell.cellImage.image = UIImage(named: categories[indexPath.row].name!)
        cell.cellLabel.font = UIFont(name: "Poppins-SemiBold", size: 18)
        cell.cellLabel.textColor = UIColor(hexString: "#626262")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.row].name
        defaults.set(selectedCategory, forKey: "selectedCategory")
        defaults.set(indexPath.row, forKey: "cID")
        defaults.synchronize()
        textField.tintColor = UIColor.clear
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
