//
//  SourcesViewController.swift
//  NewsApp
//
//  Created by ios4 on 18/05/21.
//

import UIKit

class SourcesViewController: UIViewController{

    // MARK: Outlets
    @IBOutlet weak var sourcesTable: UITableView!
    
    // MARK: Variables
    private var newsSources : SourcesDM!
    var loadingVC: UIViewController!
    
    // MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // MARK: Add loader
        loadingVC = LoadingViewController()
        loadingVC.modalPresentationStyle = .overCurrentContext
        loadingVC.modalTransitionStyle = .crossDissolve
        setupNavigationBarItems()
        setupTableView()
    }
    
    // MARK: Custom Navigation Bar
    private func setupNavigationBarItems() {
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.backgroundColor = .systemBackground
        }
        let titleText = UILabel()
        titleText.text = "Sources"
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

// MARK: Custom Table View Cell
class SourcesCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#b80d00")
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    let sourceLabel: UILabel = {
        let sourceLabel = UILabel()
        sourceLabel.font = UIFont(name: "Poppins-SemiBold", size: 15)
        sourceLabel.textColor = UIColor(hexString: "#fefefe")
        sourceLabel.textAlignment = .center
        sourceLabel.text = "Source Name"
        sourceLabel.translatesAutoresizingMaskIntoConstraints = false
        return sourceLabel
    }()
    
    private func setupView() {
        addSubview(cellView)
        cellView.addSubview(sourceLabel)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cellView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -14)
        ])
        cellView.addShadow(shadowColor: UIColor(hexString: "#303030").cgColor, shadowOffset: CGSize(width: 1, height: 1), shadowOpacity: 0.7, shadowRadius: 2.5)
        
        sourceLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        sourceLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    }
}

// MARK: Table View Delegate and Data Source
extension SourcesViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Table Functions
    func setupTableView() {
        sourcesTable.register(SourcesCell.self, forCellReuseIdentifier: "cellId")
        view.addSubview(sourcesTable)
        sourcesTable.delegate = self
        sourcesTable.dataSource = self
//        self.getSources()
//        self.callA
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if SourcesVM.shared.newsSources.sources.count == 0 {
            self.sourcesTable.setEmptyView(message: "Sources Not Available.")
        }
        else {
            self.sourcesTable.restore()
        }
        return SourcesVM.shared.newsSources.sources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sourcesTable.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! SourcesCell
        let sources = SourcesVM.shared.newsSources.sources[indexPath.row]
        cell.sourceLabel.text = sources.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sources = SourcesVM.shared.newsSources.sources[indexPath.row]
        Selection.instance.selectedSourceId = sources.id ?? ""
        Selection.instance.selectedSourceName = sources.name ?? ""
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "NewsViewController") as! NewsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SourcesViewController {
    func callApiToGetSources(){
        SourcesVM.shared.callApiToGetSources() { (message, error) in
            if error != nil {
                self.showErrorMessage(error: error)
            }else {
                self.sourcesTable.reloadData()
              
            }
        }
    }
//    func getSources() {
//        self.present(self.loadingVC, animated: true, completion: nil)
//        SourcesVM.shared.getSources() { (newsSources) in
//            self.newsSources = newsSources
//            self.sourcesTable.delegate = self
//            self.sourcesTable.dataSource = self
//            self.sourcesTable.reloadData()
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
}
