//
//  SelectCategoryViewcontroller.swift
//  NewsApp
//
//  Created by ios4 on 17/05/21.
//

import UIKit

class SelectCategoryViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    
    // MARK: Variables
    let defaults = UserDefaults.standard
    private let categories = CategoryList.getCategories()
    
    // MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        setupNavigationBarItems()
        setupCollectionView()
        setupFonts()
    }
    
    // MARK: Set up Fonts
    private func setupFonts() {
        titleLabel.font = UIFont(name: "Poppins-Regular", size: 16)
        titleLabel.textColor = UIColor(hexString: "#626262")
    }
    
    // MARK: Custom Navigation Bar
    private func setupNavigationBarItems() {
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.backgroundColor = .systemBackground
        }
        let titleText = UILabel()
        titleText.text = "Categories"
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
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "SelectCountryViewController") as! SelectCountryViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

// MARK: Custom Collection View Cell
class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
}

// MARK: Collection View Delegate, Data Source and Delegate Flow Layout
extension SelectCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: Collection View Functions
    func setupCollectionView() {
        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "cellId")
        view.addSubview(categoryCollectionView)
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
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
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = categoryCollectionView.cellForItem(at: indexPath)
        cell?.isSelected = true
        let selectedCategory = categories[indexPath.row].name
        defaults.set(selectedCategory, forKey: "selectedCategory")
        let cID = indexPath.row
        defaults.set(cID, forKey: "cID")
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = categoryCollectionView.cellForItem(at: indexPath)
        cell?.isSelected = false
    }
    
    // MARK: View Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let flowLayout = self.categoryCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 0
            flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 32)/2, height: 145)
        }
    }
}
