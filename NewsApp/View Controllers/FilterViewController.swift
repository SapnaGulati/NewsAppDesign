//
//  FilterViewController.swift
//  NewsApp
//
//  Created by ios4 on 18/05/21.
//

import UIKit

class FilterViewController: UIViewController {
    
    // MARK: Outlets
    private let categories = CategoryList.getCategories()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    let defaults = UserDefaults.standard
    var selectedCountry: String!

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
        defaults.set(selectedCountry, forKey: "selectedCountry")
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
        collectionView.register(FilterCell.self, forCellWithReuseIdentifier: "cellId")
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: Flow Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.minimumInteritemSpacing = 8
            flowLayout.minimumLineSpacing = 8
            flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 40)/2, height: 150)
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
        let cID = defaults.integer(forKey: "cID")
        if indexPath.row == cID {
            cell.isSelected = true
        }
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
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:12).cgPath
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedCountry = categories[indexPath.row].name
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected = true
        cell?.layer.cornerRadius = 12.0
        cell?.layer.borderColor = UIColor(hexString: "#b80d00").cgColor
        cell?.layer.borderWidth = 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.isSelected = false
        cell?.layer.cornerRadius = 12.0
        cell?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.layer.borderWidth = 2
    }
}
