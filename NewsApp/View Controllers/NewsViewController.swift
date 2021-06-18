//
//  NewsViewController.swift
//  NewsApp
//
//  Created by ios4 on 15/06/21.
//

import UIKit
import SafariServices
import SDWebImage

enum NewsComeFrom: String {
    case Search
    case Sources
}

class NewsViewController: BaseVC {
    
    // MARK: Outlets
    @IBOutlet weak var newsTableView: UITableView!
    
    // MARK: Variables
    var url: URL!
    var loadingVC: UIViewController!
    private var newsData : NewsDM!
    var newsComeFrom: NewsComeFrom = .Sources
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Add loader
        loadingVC = LoadingViewController()
        loadingVC.modalPresentationStyle = .overCurrentContext
        loadingVC.modalTransitionStyle = .crossDissolve
        
        setupTableView()
        setupNavigationBarItems(title: Selection.instance.selectedSourceName)
    }
    
    // MARK: Custom Navigation Bar
    private func setupNavigationBarItems(title: String) {
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.backgroundColor = .systemBackground
        }
        let titleText = UILabel()
        if newsComeFrom == .Sources {
            titleText.text = title
        }
        else {
            titleText.text = Selection.instance.searchParams
        }
        titleText.font = UIFont(name: "Poppins-Medium", size: 21)
        titleText.textColor = UIColor(hexString: "#b80d00")
        titleText.frame = CGRect(x:0, y: 0, width: 100, height: 34)
        titleText.textAlignment = .center
        navigationItem.titleView = titleText
        
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "backArrow")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: UIControl.State.normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        backButton.addTarget(self, action: #selector(gotoPrevVC), for: .touchUpInside)
    }
    
    @objc func gotoPrevVC() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: Table View Delegate and Data Source
extension NewsViewController:  UITableViewDelegate, UITableViewDataSource{
    
    func setupTableView() {
        self.newsTableView.register(UINib.init(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.newsTableView.delegate = self
        self.newsTableView.dataSource = self
        self.callApiToGetArticles()
    }
    
    // MARK: Table View Delegate Function
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.newsTableView.bounds.height
    }
    
    // MARK: Table View Data Source Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsVM.shared.newsData.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newsTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        // MARK: Label Taps
        let moreTap = UITapGestureRecognizer(target: self, action: #selector(self.moreLabelTapped(_:)))
        moreTap.numberOfTapsRequired = 1
        cell.moreLabel.isUserInteractionEnabled = true
        cell.moreLabel.addGestureRecognizer(moreTap)
        
        // MARK: Fill data in Table View Cell
        let items = NewsVM.shared.newsData.articles[indexPath.row]
        cell.titleLabel?.text = items.title ?? ""
        cell.contentLabel?.text = items.description
        cell.dateLabel?.text = items.publishedAt
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
    
    @objc func shareButtonPressed() {
        let activityVC = UIActivityViewController(activityItems: [self.url ?? ""], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
}

extension NewsViewController {
    
    func callApiToGetArticles() {
        NewsVM.shared.callApiToGetArticlesBySource(selectedSource: Selection.instance.selectedSourceId) { (message, error) in
            if error != nil {
                self.showErrorMessage(error: error)
            }else {
                if NewsVM.shared.newsData.articles.count == 0 {
                    self.newsTableView.setEmptyView(message: "News Not Available.")
                }
                else {
                    self.newsTableView.restore()
                }
                self.newsTableView.reloadData()
              
            }
        }
    }
}
