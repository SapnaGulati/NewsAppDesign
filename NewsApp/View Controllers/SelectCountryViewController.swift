//
//  SelectCountryViewController.swift
//  NewsApp
//
//  Created by ios4 on 13/05/21.
//

import UIKit

enum ComeFrom: String {
    case LogIn
    case Preferences
}

class SelectCountryViewController: BaseVC {

    // MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countryTableView: UITableView!
    @IBOutlet weak var doneToolbar: UIToolbar!
    
    // MARK: Variables
    var delegate: SelectCountry?
    var comeFrom: ComeFrom = .LogIn
    private var countries = [CountryDM]()
    var filteredData = [CountryDM]()
    var flagString: String?

    // MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredStatusBarStyle.setupStatusBar(string: "#b80d00")
        setupNavigationBarItems()
        setupSearchBar()
        setupTableView()
        setupFonts()
//        countryTableView.isScrolling
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(SelectCountryViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SelectCountryViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: Keyboard Functions
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height {
            self.countryTableView.setBottomInset(to: keyboardHeight)
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        self.countryTableView.setBottomInset(to: 0.0)
    }
    
    // MARK: Button Actions
    @IBAction func doneButton(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    // MARK: Set Up Fonts
    private func setupFonts() {
        titleLabel.font = UIFont(name: "Poppins-Regular", size: 16)
        titleLabel.textColor = UIColor(hexString: "#626262")
    }
    
    // MARK: Set Up Search Bar
    private func setupSearchBar() {
        let attributes = [
        NSAttributedString.Key.foregroundColor: UIColor(hexString: "#626262"),
        NSAttributedString.Key.font : UIFont(name: "Poppins-Regular", size: 13)!
        ]
        if #available(iOS 13.0, *) {
            searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes:attributes)
            searchBar.backgroundColor = .white
            searchBar.clipsToBounds = true
            searchBar.layer.borderWidth = 2
            searchBar.layer.borderColor = UIColor.systemGray6.cgColor
            searchBar.searchTextField.textColor = .black
            searchBar.layer.cornerRadius = 25
            searchBar.layer.frame.size.height = 60
            searchBar.searchTextField.backgroundColor = .white
        }
        searchBar.tintColor = UIColor(hexString: "#b80d00")
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
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
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 0.3
        view.layer.borderColor = UIColor.black.cgColor
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
    
    // MARK: Setting-up View
    func setupView() {
        addSubview(cellView)
        cellView.addSubview(countryImageView)
        cellView.addSubview(countryNameLabel)
        self.selectionStyle = .none
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 13),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        cellView.backgroundColor = UIColor(hexString: "#616163")
        cellView.addShadow(shadowColor: UIColor(hexString: "#303030").cgColor, shadowOffset: CGSize(width: 1, height: 1.5), shadowOpacity: 1, shadowRadius: 3.5)
        
        countryImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor, constant: 6).isActive = true
        countryImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant: 20).isActive = true
        countryImageView.widthAnchor.constraint(equalToConstant:30).isActive = true
        countryImageView.heightAnchor.constraint(equalToConstant:30).isActive = true
        
        countryNameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 8).isActive = true
        countryNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        countryNameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        countryNameLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 50).isActive = true
        countryNameLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 150).isActive = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)
         if selected {
            cellView.backgroundColor = UIColor(hexString: "#b80d00")
            cellView.addShadow(shadowColor: UIColor(hexString: "#303030").cgColor, shadowOffset: CGSize(width: 1, height: 1.5), shadowOpacity: 1, shadowRadius: 3.5)
         } else {
            cellView.backgroundColor = UIColor(hexString: "#616163")
            cellView.addShadow(shadowColor: UIColor(hexString: "#303030").cgColor, shadowOffset: CGSize(width: 1, height: 1.5), shadowOpacity: 1, shadowRadius: 3.5)
         }
     }
}

// MARK: Search Bar Delegate
extension SelectCountryViewController: UISearchBarDelegate{
    
    // MARK: Search Bar Data Update
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredData.removeAll()
        if(searchBar.text?.isEmpty)! {
            self.filteredData = self.countries
        }
        else {
            if self.countries.count > 0 {
                for i in 0...self.countries.count - 1 {
                    let coun = self.countries[i]
                    if coun.name?.range(of: searchBar.text!, options: .caseInsensitive) != nil {
                        self.filteredData.append(coun)
                    }
                }
            }
        }
        self.countryTableView.reloadData()
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.inputAccessoryView = doneToolbar
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.countryTableView.reloadData()
    }
}

// MARK: Table View Delegate and Data Source
extension SelectCountryViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Table View Functions
    func setupTableView() {
        countryTableView.register(CountryCell.self, forCellReuseIdentifier: "cellId")
        view.addSubview(countryTableView)
        countryTableView.delegate = self
        countryTableView.dataSource = self
        callApiForCountry()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countryTableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CountryCell
        cell.countryNameLabel.text = filteredData[indexPath.row].name
        flagString = CountryCode.shared.getFlag(country: filteredData[indexPath.row].name!)
        cell.countryImageView.image = flagString?.image()
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DataManager.selectedCountry = filteredData[indexPath.row].name
        flagString = CountryCode.shared.getFlag(country: DataManager.selectedCountry ?? "")
        Selection.instance.selectedFlag = flagString ?? ""
        delegate?.setCountry(cName: DataManager.selectedCountry ?? "", flag: Selection.instance.selectedFlag)
        
        if comeFrom == .LogIn {
            self.view.endEditing(true)
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "SelectCategoryViewController") as! SelectCategoryViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.resignFirstResponder()
        self.view.endEditing(true)
    }
}

extension SelectCountryViewController {
    func callApiForCountry(){
        countries.removeAll()
        CountryVM.shared.callApiForCountry() { (message, error) in
            if error != nil {
                self.showErrorMessage(error: error)
            }else {
                self.countries = CountryVM.shared.country
                self.filteredData = self.countries
                self.countryTableView.reloadData()
            }
        }
    }
}

extension CountryVM {
    func parsingCountryData(response: JSONArray)  {
        self.country.removeAll()
        var data = JSONDictionary()
        for response in response {
            data[APIKeys.kCode] = response[APIKeys.kCode] as? String ?? ""
            data[APIKeys.kFlag] = response[APIKeys.kFlag] as? String ?? ""
            data[APIKeys.kName] = response[APIKeys.kName] as? String ?? ""
            let countriesDetail = CountryDM(dict: data)
            self.country.append(countriesDetail)
        }
    }
}
