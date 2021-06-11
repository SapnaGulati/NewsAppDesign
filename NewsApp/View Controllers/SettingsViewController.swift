//
//  SettingsViewController.swift
//  NewsApp
//
//  Created by ios4 on 17/05/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var settingsTable: UITableView!
    
    // MARK: Variables
    let settings = SettingsList.getSettings()
    var vc = [String]()
    
    // MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        setupNavigationBarItems()
        setupTableView()
        
        vc = ["PreferencesViewController", "SourcesViewController", "BookMarksViewController", "SubscriptionViewController"]
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
        titleText.text = "Settings"
        titleText.font = UIFont(name: "Poppins-Medium", size: 21)
        titleText.textColor = UIColor(hexString: "#b80d00")
        titleText.frame = CGRect(x:0, y: 0, width: 100, height: 34)
        self.parent?.navigationItem.titleView = titleText
        self.parent?.navigationItem.leftBarButtonItem = .none
        self.parent?.navigationItem.rightBarButtonItem = .none
        self.parent?.navigationItem.hidesBackButton = true
    }
}

// MARK: Custom Table View Cell
class SettingsCell: UITableViewCell {
    
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
        
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-SemiBold", size: 15)
        label.textColor = UIColor(hexString: "#fefefe")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupView() {
        addSubview(cellView)
        cellView.addSubview(label)
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
        label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    }
}

// MARK: Table View Delegate and Data Source
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Table View Functions
    func setupTableView() {
        settingsTable.register(SettingsCell.self, forCellReuseIdentifier: "cellId")
        view.addSubview(settingsTable)
        settingsTable.isScrollEnabled = false
        settingsTable.delegate = self
        settingsTable.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTable.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! SettingsCell
        cell.label.text = settings[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 4) {
            let alertDialog = UINavigationController.init(rootViewController: self.storyboard!.instantiateViewController(withIdentifier: "LogoutViewController"))
            alertDialog.modalPresentationStyle = .overCurrentContext
            alertDialog.providesPresentationContextTransitionStyle = true
            alertDialog.definesPresentationContext = true
            alertDialog.modalTransitionStyle = .crossDissolve
            self.present(alertDialog, animated: true, completion: {})
        }
        else {
            let vcName = vc[indexPath.row]
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: vcName)
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
    }
}
