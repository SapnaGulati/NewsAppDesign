//
//  SearchTableViewController.swift
//  NewsApp
//
//  Created by ios4 on 19/05/21.
//

import UIKit

class SearchTableViewController: UIViewController {
    
    // MARK: Data Initialization
    let data = ["Trump has a data", "Trump has a data", "Trump has a data", "Trump has a data", "Trump has a data", "Trump has a data", "No data"]
    var filteredData: [String]!
    
    // MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    // View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        filteredData = data
        setupSearchBar()
        setupTableView()
        tvHeight.constant = CGFloat((self.filteredData.count + 1) * 40)
    }
    
    // MARK: Search Bar Set Up
    private func setupSearchBar() {
        let attributes = [
        NSAttributedString.Key.foregroundColor: UIColor(hexString: "#b80d00"),
        NSAttributedString.Key.font : UIFont(name: "Poppins-Medium", size: 13)!
        ]
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes:attributes)
            searchBar.returnKeyType = .done
            searchBar.backgroundColor = .white
            searchBar.clipsToBounds = true
            searchBar.layer.frame.size.height = 40
            searchBar.searchTextField.backgroundColor = .white
            searchBar.searchTextField.layer.borderColor = UIColor.white.cgColor
            searchBar.searchTextField.layer.borderWidth = 2
            searchBar.layer.borderColor = UIColor.systemGray6.cgColor
            searchBar.layer.cornerRadius = 12
        }
        searchBar.delegate = self
        searchBar.tintColor = UIColor(hexString: "#b80d00")
        searchBar.setImage(UIImage(named: "searchR"), for: .search, state: .normal)
        searchBar.backgroundImage = UIImage()
    }
    
    // MARK: Custom Navigation Bar
    private func setupNavigationBarItems() {
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.backgroundColor = .systemBackground
        }
        let titleText = UILabel()
        titleText.text = "Search"
        titleText.font = UIFont(name: "Poppins-Medium", size: 21)
        titleText.textColor = UIColor(hexString: "#b80d00")
        titleText.frame = CGRect(x:0, y: 0, width: 100, height: 34)
        navigationItem.titleView = titleText
        
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "backArrow")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: UIControl.State.normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        backButton.addTarget(self, action: #selector(gotoTab), for: .touchUpInside)
        
        let deleteButton = UIButton(type: .system)
        deleteButton.setImage(UIImage(named: "delete")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: UIControl.State.normal)
        deleteButton.frame = CGRect(x: 0, y:0, width: 34, height: 34)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: deleteButton)
    }
    
    @objc func gotoTab() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: Search Bar Data Update
extension SearchTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        
        if searchText == "" {
            filteredData = data
        }
        else {
            for search in data {
                if search.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(search)
                }
            }
        }
        self.tvHeight.constant = CGFloat((self.filteredData.count + 1) * 40)
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: Table View Delegate and Data Source
extension SearchTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.layer.borderColor = UIColor.lightGray.cgColor
        self.tableView.layer.borderWidth = 1
        self.tableView.layer.cornerRadius = 12
        self.tableView.backgroundColor = UIColor(hexString: "#d6d4d3")
        self.tableView.layer.shadowColor = UIColor.black.cgColor
        self.tableView.layer.shadowRadius = 5
        self.tableView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.tableView.layer.shadowOpacity = 0.8
        self.tableView.layer.masksToBounds = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = filteredData[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Poppins-Medium", size: 15)
        cell.textLabel?.highlightedTextColor = UIColor(hexString: "#d9d3cc")
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(hexString: "#555454")
        if(cell.isSelected) {
            cell.selectedBackgroundView = bgColorView
        } else {
            cell.textLabel?.textColor = UIColor(hexString: "#918e8c")
            cell.backgroundColor = UIColor(hexString: "#d6d4d3")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = true
        cell?.isHighlighted = true
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(hexString: "#555454")
        cell?.selectedBackgroundView = bgColorView
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isSelected = false
        cell?.isHighlighted = false
        cell?.backgroundColor = UIColor(hexString: "#d6d4d3")
        cell?.textLabel?.textColor = UIColor(hexString: "#918e8c")
    }
}
