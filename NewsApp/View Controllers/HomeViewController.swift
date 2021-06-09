//
//  HomeViewController.swift
//  NewsApp
//
//  Created by ios4 on 17/05/21.
//

import UIKit
import SafariServices
import SDWebImage

class HomeViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    var url: URL!
    var loadingVC: UIViewController!
    private var newsData : NewsDataModel!
    let defaults = UserDefaults.standard
    // MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: Add loader
        loadingVC = LoadingViewController()
        loadingVC.modalPresentationStyle = .overCurrentContext
        loadingVC.modalTransitionStyle = .crossDissolve
        
        self.navigationController?.isNavigationBarHidden = false
        setupNavigationBarItems()
        self.setupTableView()
        NewsVM.shared.newsData.articles.removeAll()
        let selectedCategory = self.defaults.string(forKey: "selectedCategory") ?? ""
        self.getArticles(selectedCategory: selectedCategory)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupNavigationBarItems()
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
        self.parent?.navigationItem.titleView = titleText
        
        let filterButton = UIButton(type: .system)
        filterButton.setImage(UIImage(named: "filter")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: UIControl.State.normal)
        filterButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        self.parent?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: filterButton)
        filterButton.addTarget(self, action: #selector(gotoFilter), for: .touchUpInside)
        
        let searchButton = UIButton(type: .system)
        searchButton.setImage(UIImage(named: "search")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: UIControl.State.normal)
        searchButton.frame = CGRect(x: 0, y:0, width: 34, height: 34)
        self.parent?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)
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

// MARK: Table View Delegate and Data Source
extension HomeViewController:  UITableViewDelegate, UITableViewDataSource{
    
    func setupTableView() {
        self.tableView.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
    
    // MARK: Table View Delegate Function
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.tableView.bounds.height
    }
    
    // MARK: Table View Data Source Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsVM.shared.newsData.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
        tap.numberOfTapsRequired = 1
        cell.moreLabel.isUserInteractionEnabled = true
        cell.moreLabel.addGestureRecognizer(tap)
        let items = NewsVM.shared.newsData.articles[indexPath.row]
        cell.titleLabel?.text = items.title ?? ""
        cell.contentLabel?.text = items.description
        cell.dateLabel?.text = items.publishedAt
        cell.homeImageView.sd_setImage(with: URL(string: items.urlToImage  ?? ""), placeholderImage: #imageLiteral(resourceName: "HomeImage"), options: .refreshCached, completed: nil)
        cell.sourceLabel?.text = items.sourceName
        self.url = URL(string: items.url ?? "")
        return cell
    }

    @objc
    func labelTapped(_ tap: UITapGestureRecognizer) {
        let safariViewController = SFSafariViewController(url: self.url)
        present(safariViewController, animated: true)
    }
}

extension HomeViewController {
    func getArticles(selectedCategory: String) {
        self.present(self.loadingVC, animated: true, completion: nil)
        NewsVM.shared.getArticles(selectedCategory: selectedCategory) { (newsData) in
            self.newsData = newsData
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
            self.dismiss(animated: true, completion: nil)
        }
    }
}
