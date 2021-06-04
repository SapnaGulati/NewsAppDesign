//
//  SelectCategoryViewcontroller.swift
//  NewsApp
//
//  Created by ios4 on 17/05/21.
//

import UIKit

class SelectCategoryViewController: UIViewController {
    
    // MARK: Outlets
    private let categories = CategoryList.getCategories()
    @IBOutlet weak var titleLabel: UILabel!
     @IBOutlet weak var collectionView: UICollectionView!
    let defaults = UserDefaults.standard
    
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
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: Custom Collection View Cell
class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
}

// Collection View Delegate, Data Source and Delegate Flow Layout
extension SelectCategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: Collection View Functions
    func setupCollectionView() {
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "cellId")
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        if(cell.isSelected) {
            cell.contentView.layer.borderColor = UIColor(hexString: "#b80d00").cgColor
        }
        else {
            cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        }
        cell.contentView.layer.cornerRadius = 12.0
        cell.contentView.layer.borderWidth = 2
        cell.cellLabel.text = categories[indexPath.row].name
        cell.cellImage.image = UIImage(named: categories[indexPath.row].name!)
        cell.cellLabel.font = UIFont(name: "Poppins-SemiBold", size: 18)
        cell.cellLabel.textColor = UIColor(hexString: "#626262")
        cell.backgroundColor = UIColor(hexString: "#efeded")
        cell.layer.shadowColor = UIColor.systemGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.layer.shadowRadius = 2
        cell.layer.shadowOpacity = 0.5
        cell.layer.masksToBounds = true
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:12).cgPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected = true
        cell?.layer.cornerRadius = 12.0
        cell?.layer.borderColor = UIColor(hexString: "#b80d00").cgColor
        cell?.layer.borderWidth = 2
        let selectedCategory = categories[indexPath.row].name
        defaults.set(selectedCategory, forKey: "selectedCategory")
        let cID = indexPath.row
        defaults.set(cID, forKey: "cID")
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected = false
        cell?.layer.cornerRadius = 12.0
        cell?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.layer.borderWidth = 2
    }
    
    // MARK: View Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacing = 8
            flowLayout.minimumLineSpacing = 8
            flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 40)/2, height: 150)
        }
    }
}
