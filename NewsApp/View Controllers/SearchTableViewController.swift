//
//  SearchTableViewController.swift
//  NewsApp
//
//  Created by ios4 on 19/05/21.
//

import UIKit

class SearchTableViewController: UIViewController {
    
    // MARK: Data Initialization
    let data = ["Trump has a data", "Trump has a data", "Trump has a data", "Trump has a data", "Trump has a data", "Trump has a data"]
    var searchParams: String = ""
    var filteredData: [String]!
    private var newsData : NewsDM!
    
    // MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var doneToolbar: UIToolbar!
    @IBOutlet weak var searchView: UIView!
    
    // View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        filteredData = data
        setupSearchBar()
        setupTableView()
        searchView.backgroundColor = UIColor(hexString: "#d6d4d3")
        searchView.layer.cornerRadius = 22
        searchView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        if(CGFloat((self.filteredData.count) * 40) <= self.view.frame.height/2.5) {
            tableViewHeight.constant = CGFloat((self.filteredData.count) * 40)
        } else {
            tableViewHeight.constant = self.view.frame.height/2.5
        }
    }
    
    @IBAction func doneButton(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    // MARK: Search Bar Set Up
    private func setupSearchBar() {
        let attributes = [
        NSAttributedString.Key.foregroundColor: UIColor(hexString: "#b80d00"),
        NSAttributedString.Key.font : UIFont(name: "Poppins-Medium", size: 13)!
        ]
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes:attributes)
            searchBar.backgroundColor = .white
            searchBar.clipsToBounds = true
            searchBar.layer.frame.size.height = 40
            searchBar.searchTextField.backgroundColor = .white
            searchBar.searchTextField.layer.borderColor = UIColor.white.cgColor
            searchBar.searchTextField.layer.borderWidth = 2
            searchBar.searchTextField.textColor = .black
            searchBar.layer.borderColor = UIColor.systemGray6.cgColor
            searchBar.layer.cornerRadius = 22
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
        self.callApiToGetArticles()
        filteredData = []
        
        if searchText == "" {
            filteredData = data
        }
        else {
            searchParams = searchText
            for search in data {
                if search.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(search)
                }
            }
        }
        self.tableViewHeight.constant = CGFloat((self.filteredData.count) * 40)
        self.searchTableView.reloadData()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.inputAccessoryView = doneToolbar
        return true
    }
}

// MARK: Table View Delegate and Data Source
extension SearchTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        self.searchTableView.delegate = self
        self.searchTableView.dataSource = self
        self.callApiToGetArticles()
        self.searchTableView.layer.borderColor = UIColor.lightGray.cgColor
        self.searchTableView.layer.borderWidth = 0
        self.searchTableView.layer.cornerRadius = 12
        self.searchTableView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        self.searchTableView.backgroundColor = UIColor(hexString: "#d6d4d3")
        self.searchTableView.layer.shadowColor = UIColor.black.cgColor
        self.searchTableView.layer.shadowRadius = 5
        self.searchTableView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.searchTableView.layer.shadowOpacity = 0.8
        self.searchTableView.layer.masksToBounds = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if(filteredData.count == 0) {
        if(NewsVM.shared.newsData.articles.count == 0) {
            searchView.backgroundColor = .none
            searchBar.layer.borderWidth = 2
            if #available(iOS 13.0, *) {
                searchBar.layer.borderColor = UIColor.systemGray6.cgColor
            }
        }
        else {
            searchView.backgroundColor = UIColor(hexString: "#d6d4d3")
        }
//        return filteredData.count
        return NewsVM.shared.newsData.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        cell.textLabel?.text = NewsVM.shared.newsData.articles[indexPath.row].title ?? ""
//        cell.textLabel?.text = filteredData[indexPath.row]
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
        let cell = searchTableView.cellForRow(at: indexPath)
        cell?.isSelected = true
        cell?.isHighlighted = true
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(hexString: "#555454")
        cell?.selectedBackgroundView = bgColorView
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = searchTableView.cellForRow(at: indexPath)
        cell?.isSelected = false
        cell?.isHighlighted = false
        cell?.backgroundColor = UIColor(hexString: "#d6d4d3")
        cell?.textLabel?.textColor = UIColor(hexString: "#918e8c")
    }
}

extension SearchTableViewController {
    func callApiToGetArticles() {
        NewsVM.shared.callApiToGetArticlesBySearch(searchParams: searchParams) { (message, error) in
            if error != nil {
                print(error as Any)
            }else {
                self.searchTableView.reloadData()
            }
        }
    }
}
