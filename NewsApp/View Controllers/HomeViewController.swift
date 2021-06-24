//
//  HomeViewController.swift
//  NewsApp
//
//  Created by ios4 on 17/05/21.
//

import UIKit
import CoreData
import SafariServices
import SDWebImage

enum CategoryComeFrom: String {
    case Filters
    case Preferences
}

class HomeViewController: BaseVC {
    
    // MARK: Outlets
    @IBOutlet weak var homeTableView: UITableView!
    
    // MARK: Variables
    var url: URL!
    var loadingVC: UIViewController!
    private var newsData : NewsDM!
    var categoryComeFrom: CategoryComeFrom = .Preferences
    
    // MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Add loader
        loadingVC = LoadingViewController()
        loadingVC.modalPresentationStyle = .overCurrentContext
        loadingVC.modalTransitionStyle = .crossDissolve
        
        self.navigationController?.isNavigationBarHidden = false
        preferredStatusBarStyle.setupStatusBar(string: "#b80d00")
        setupNavigationBarItems()
        self.setupTableView()
        fetchUser()
    }
    
    func fetchUser()
    {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        debugPrint(path[0])
        do {
            guard let result = try PersistentStorage.shared.context.fetch(CDUsers.fetchRequest()) as? [CDUsers] else {return}
            result.forEach({debugPrint(($0.userId ?? "") as String)})
        } catch let error
        {
            debugPrint(error)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
        setupNavigationBarItems()
    }
    
    // MARK: Custom Navigation Bar
    private func setupNavigationBarItems() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = (UIImage())
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
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
        self.homeTableView.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        self.callApiToGetArticles()
    }
    
    // MARK: Table View Delegate Function
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.homeTableView.bounds.height
    }
    
    // MARK: Table View Data Source Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsVM.shared.newsData.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        // MARK: Label Taps
        let moreTap = UITapGestureRecognizer(target: self, action: #selector(self.moreLabelTapped(_:)))
        moreTap.numberOfTapsRequired = 1
        cell.moreLabel.isUserInteractionEnabled = true
        cell.moreLabel.addGestureRecognizer(moreTap)
        let sourceTap = UITapGestureRecognizer(target: self, action: #selector(self.sourceLabelTapped(_:)))
        sourceTap.numberOfTapsRequired = 1
        cell.sourceLabel.isUserInteractionEnabled = true
        cell.sourceLabel.addGestureRecognizer(sourceTap)
        
        // MARK: Fill Data in Table View Cell
        let items = NewsVM.shared.newsData.articles[indexPath.row]
        cell.titleLabel?.text = items.title ?? ""
        cell.contentLabel?.text = items.description
        
        // MARK: Decode date into right format
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"

        if let date = dateFormatterGet.date(from: items.publishedAt ?? "") {
            cell.dateLabel?.text = (dateFormatterPrint.string(from: date))
        }
        cell.homeImageView.sd_setImage(with: URL(string: items.urlToImage  ?? ""), placeholderImage: #imageLiteral(resourceName: "HomeImage"), options: .refreshCached, completed: nil)
        cell.sourceLabel?.text = items.sourceName
        self.url = URL(string: items.url ?? "")
        cell.shareButton.addTarget(self, action: #selector(self.shareButtonPressed), for: .touchUpInside)
        return cell
    }

    @objc
    func moreLabelTapped(_ tap: UITapGestureRecognizer) {
        let safariViewController = SFSafariViewController(url: self.url)
        present(safariViewController, animated: true)
    }
    
    @objc func sourceLabelTapped(_ tap: UITapGestureRecognizer) {
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "SourcesViewController") as! SourcesViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func shareButtonPressed() {
        let activityVC = UIActivityViewController(activityItems: [self.url ?? ""], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
}

extension HomeViewController {
    func callApiToGetArticles() {
        let selectedCategory: String!
        if categoryComeFrom == .Filters {
            selectedCategory = DataManager.selectedCategory
        }
        else {
            selectedCategory = Selection.instance.selectedCategory
        }
        NewsVM.shared.callApiToGetArticlesByCounAndCat(selectedCountry: CountryCode.shared.getCode(country: DataManager.selectedCountry ?? ""), selectedCategory: selectedCategory ?? "") { (message, error) in
            if error != nil {
                self.showErrorMessage(error: error)
            }else {
                if NewsVM.shared.newsData.articles.count == 0 {
                    self.homeTableView.setEmptyView(message: "News Not Available.")
                }
                else {
                    self.homeTableView.restore()
                }
                self.homeTableView.reloadData()
            }
        }
    }
}
