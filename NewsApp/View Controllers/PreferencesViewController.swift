//
//  PreferencesViewController.swift
//  NewsApp
//
//  Created by ios4 on 18/05/21.
//

import UIKit

class PreferencesViewController: UIViewController, SelectCountry {
    
    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var textField: UITextField!
    
    // MARK: Variables
    var leftIconView: UIImageView!
    private let categories = CategoryList.getCategories()

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
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.arrowTapped(_:)))
        tap.numberOfTapsRequired = 1
        textField.addGestureRecognizer(tap)
        textField.isUserInteractionEnabled = true
        if #available(iOS 13.0, *) {
            textField.layer.borderColor = UIColor.systemGray6.cgColor
        } else {
            textField.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    // MARK: Text Field Setup
    private func setupTextField() {
        let padding = 10
        let size = 30
        self.textField.text = DataManager.selectedCountry
        let leftImage = Selection.instance.selectedFlag.image()
        let outerLeftView = UIView(frame: CGRect(x: 20, y: 0, width: size+padding+16, height: 36))
        let anotherView = UIView(frame: CGRect(x:20, y:2, width: size+6, height: 32))
        leftIconView  = UIImageView(frame: CGRect(x: 0, y: 0, width: size+4, height: 30))
        anotherView.layer.borderWidth = 0.5
        anotherView.layer.borderColor = UIColor.lightGray.cgColor
        anotherView.layer.cornerRadius = 3.5
        leftIconView.contentMode = .center
        leftIconView.clipsToBounds = true
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
        let outerRightView = UIView(frame: CGRect(x: 0, y: 0, width: size+padding+16, height: 10))
        let rightIconView  = UIImageView(frame: CGRect(x: padding, y: 0, width: size+16, height: 8))
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
    func setCountry(cName: String, flag: String) {
        leftIconView.image = flag.image()
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
        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "cellId")
        view.addSubview(categoryCollectionView)
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }
    
    // MARK: Flow Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let flowLayout = self.categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
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
        if indexPath.row == DataManager.selectedCategoryIndex {
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
        DataManager.selectedCategory  = categories[indexPath.row].name!
        DataManager.selectedCategoryIndex = indexPath.row
        self.categoryCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
