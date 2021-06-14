//
//  FilterViewController.swift
//  NewsApp
//
//  Created by ios4 on 18/05/21.
//

import UIKit

class FilterViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var filterCategoriesCollectionView: UICollectionView!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    // MARK: Variables
    private let categories = CategoryList.getCategories()
    var selectedCategory: String!

    // MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        setupFonts()
        setupCollectionView()
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK: Set Up Fonts
    private func setupFonts() {
        searchLabel.font = UIFont(name: "Poppins-Regular", size: 17)
        searchLabel.textColor = UIColor(hexString: "#b80d00")
        dataLabel.font = UIFont(name: "Poppins-Regular", size: 17)
        dataLabel.textColor = UIColor(hexString: "#626262")
        categoriesLabel.font = UIFont(name: "Poppins-SemiBold", size: 20)
        categoriesLabel.textColor = UIColor(hexString: "#b80d00")
        resetButton.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 20)
        resetButton.titleLabel?.textColor = UIColor(hexString: "#ffffff")
        resetButton.backgroundColor = UIColor(hexString: "#b80d00")
        resetButton.layer.cornerRadius = 10
    }
    
    // MARK: Reset Button Click Handling
    @IBAction func ResetButton(_ sender: UIButton) {
//        Selection.instance.selectedCategory = selectedCategory
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Custom Navigation Bar
    private func setupNavigationBarItems() {
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.backgroundColor = .systemBackground
        }
        let titleText = UILabel()
        titleText.text = "Filters"
        titleText.font = UIFont(name: "Poppins-Medium", size: 21)
        titleText.textColor = UIColor(hexString: "#b80d00")
        titleText.frame = CGRect(x:0, y: 0, width: 80, height: 34)
        navigationItem.titleView = titleText
        
        let deleteButton = UIButton(type: .system)
        deleteButton.setImage(UIImage(named: "close")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: UIControl.State.normal)
        deleteButton.frame = CGRect(x: 0, y:0, width: 34, height: 34)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: deleteButton)
        deleteButton.addTarget(self, action: #selector(gotoTab), for: .touchUpInside)
    }
    
    @objc func gotoTab() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: Custom Collection View Cell
class FilterCell: UICollectionViewCell {
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
}

extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: Collection View Functions
    func setupCollectionView() {
        filterCategoriesCollectionView.register(FilterCell.self, forCellWithReuseIdentifier: "cellId")
        view.addSubview(filterCategoriesCollectionView)
        filterCategoriesCollectionView.delegate = self
        filterCategoriesCollectionView.dataSource = self
    }
    
    // MARK: Flow Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let flowLayout = self.filterCategoriesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacing = 0
            flowLayout.minimumLineSpacing = 0
            flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 32)/2, height: 145)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filterCell", for: indexPath) as! FilterCell
        if indexPath.row == Selection.instance.selectedCategoryCell {
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
        Selection.instance.selectedCategoryCell = indexPath.row
        selectedCategory = categories[indexPath.row].name
        Selection.instance.selectedCategory = selectedCategory
        self.filterCategoriesCollectionView.reloadData()
    }
}
