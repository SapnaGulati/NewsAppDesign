//
//  SelectCountryViewController.swift
//  NewsApp
//
//  Created by ios4 on 13/05/21.
//

import UIKit

class SelectCountryViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var countrytableview: UITableView!
    private let countries = CountryList.getCountries()
    var filteredData: [country] = []
    let defaults = UserDefaults.standard

    // MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredStatusBarStyle.setupStatusBar(string: "#b80d00")
        setupNavigationBarItems()
        setupSearchBar()
        filteredData = countries
        setupTableView()
        setupFonts()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    // MARK: Set Up Fonts
    private func setupFonts() {
        label2.font = UIFont(name: "Poppins-Regular", size: 16)
        label2.textColor = UIColor(hexString: "#626262")
    }
    
    // MARK: Set Up Search Bar
    private func setupSearchBar() {
        let attributes = [
        NSAttributedString.Key.foregroundColor: UIColor(hexString: "#626262"),
        NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 13)!
        ]
        if #available(iOS 13.0, *) {
            search.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes:attributes)
            search.returnKeyType = .done
            search.searchTextField.backgroundColor = .white
            search.searchTextField.clipsToBounds = true
            search.searchTextField.layer.borderWidth = 2
            search.searchTextField.layer.borderColor = UIColor.systemGray6.cgColor
            search.searchTextField.layer.cornerRadius = 20
            search.searchTextField.frame.size.height = 60
        }
        search.tintColor = UIColor(hexString: "#b80d00")
        search.backgroundImage = UIImage()
        search.delegate = self
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
        titleText.text = "Countries"
        titleText.font = UIFont(name: "Poppins-Medium", size: 21)
        titleText.textColor = UIColor(hexString: "#b80d00")
        titleText.frame = CGRect(x:0, y: 0, width: 100, height: 34)
        navigationItem.titleView = titleText
    }
}

// MARK: Custom Table View Cell
class CountryCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let countryImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .center
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 5
        img.clipsToBounds = true
        img.layer.borderWidth = 3
        img.layer.borderColor = UIColor.white.cgColor
        img.backgroundColor = .white
        return img
    }()
        
    let countryNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Medium", size: 15)
        label.textColor = UIColor(hexString: "#fefefe")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupView() {
        addSubview(cellView)
        cellView.addSubview(countryImageView)
        cellView.addSubview(countryNameLabel)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        cellView.layer.shadowColor = UIColor.systemGray.cgColor
        cellView.layer.shadowOffset = (CGSize(width: 1, height: 0.8))
        cellView.layer.shadowRadius = 2
        cellView.layer.shadowOpacity = 0.5
        
        countryImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor, constant: 10).isActive = true
        countryImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant: 20).isActive = true
        countryImageView.widthAnchor.constraint(equalToConstant:30).isActive = true
        countryImageView.heightAnchor.constraint(equalToConstant:30).isActive = true
        
        countryNameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 12).isActive = true
        countryNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        countryNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        countryNameLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 50).isActive = true
        countryNameLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 150).isActive = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)
         if selected {
             cellView.backgroundColor = UIColor(hexString: "#b80d00")
         } else {
             cellView.backgroundColor = UIColor(hexString: "#616163")
         }
     }
}

// MARK: Search Bar Delegate
extension SelectCountryViewController: UISearchBarDelegate{
    // MARK: Search Bar Data Update
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
            
        if searchText == "" {
            filteredData = countries
        }
        else {
            for character in countries {
                if (character.name.lowercased().contains(searchText.lowercased())) {
                    filteredData.append(character)
                }
            }
        }
        self.countrytableview.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: Table View Delegate and Data Source
extension SelectCountryViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Table View Functions
    func setupTableView() {
        countrytableview.register(CountryCell.self, forCellReuseIdentifier: "cellId")
        view.addSubview(countrytableview)
        countrytableview.delegate = self
        countrytableview.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countrytableview.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CountryCell
        cell.countryNameLabel.text = filteredData[indexPath.row].name
        cell.countryImageView.image = UIImage(named: filteredData[indexPath.row].name)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountry = filteredData[indexPath.row].c_code
        defaults.set(selectedCountry, forKey: "selectedCountry")
        let vc = self.storyboard!.instantiateViewController(withIdentifier: "SelectCategoryViewController") as! SelectCategoryViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension UIStatusBarStyle {
    func setupStatusBar(string: String) {
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = UIColor(hexString: string)
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(statusBar)
        }
        else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = UIColor(hexString: "#b80d00")
        }
    }
}
