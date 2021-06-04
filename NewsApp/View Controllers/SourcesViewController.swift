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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItems()
        setupTableView()
    }
    
    // MARK: Csutom Navigation Bar
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
        view.layer.borderWidth = 3
        if #available(iOS 13.0, *) {
            view.layer.borderColor = UIColor.systemBackground.cgColor
        }
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-SemiBold", size: 15)
        label.textColor = UIColor(hexString: "#fefefe")
        label.textAlignment = .center
        label.text = "Source Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupView() {
        addSubview(cellView)
        cellView.addSubview(label)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cellView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 10).isActive = true
        label.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        cellView.layer.shadowColor = UIColor.systemGray.cgColor
        cellView.layer.shadowOffset = (CGSize(width: 1, height: 1))
        cellView.layer.shadowRadius = 2
        cellView.layer.shadowOpacity = 0.5
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
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sourcesTable.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! SourcesCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 15-1, section: 0)
            self.sourcesTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}
