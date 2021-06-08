//
//  HomeViewController.swift
//  NewsApp
//
//  Created by ios4 on 17/05/21.
//

import UIKit
import SafariServices

class HomeViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    var url: URL!
    var loadingVC: UIViewController!
    private var newsService : NewsAPIService!
    private var newsData : NewsDataModel!

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
        self.newsService =  NewsAPIService()
        self.getArticles()
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
        return NewsAPIService.shared.newsData.articles.count
//        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
        tap.numberOfTapsRequired = 1
        cell.moreLabel.isUserInteractionEnabled = true
        cell.moreLabel.addGestureRecognizer(tap)
        let items = NewsAPIService.shared.newsData.articles[indexPath.row]
//        print(items.author!)
        cell.titleLabel?.text = items.title ?? ""
        cell.contentLabel?.text = items.description
        cell.dateLabel?.text = items.publishedAt
        cell.sourceLabel?.text = items.source.endIndex.description
        DispatchQueue.main.async {
//            let imageURL = URL(string: items.urlToImage ?? "HomeImage")
//            if let data = try? Data(contentsOf: imageURL!) {
//                cell.imageView?.image = UIImage(data: data)
//            }
//            self.url = URL(string: items.url ?? "")
        }
        cell.imageView?.contentMode = .scaleToFill
        cell.imageView?.translatesAutoresizingMaskIntoConstraints = false
        cell.imageView?.heightAnchor.constraint(equalToConstant: 200).isActive = true
        cell.imageView?.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        return cell
    }

    @objc
    func labelTapped(_ tap: UITapGestureRecognizer) {
        let safariViewController = SFSafariViewController(url: self.url)
        present(safariViewController, animated: true)
    }
}

extension HomeViewController {
    func getArticles() {
        self.present(self.loadingVC, animated: true, completion: nil)
        NewsAPIService.shared.getArticles { (newsData) in
            self.newsData = newsData
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
            self.dismiss(animated: true, completion: nil)
        }
    }
}
