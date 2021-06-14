////
////  BaseVC.swift
////  DT MedNet
////
////  Created by IOS on 23/09/19.
////  Copyright © 2019 Deftsoft. All rights reserved.
////
//
//import UIKit
//import AVKit
//import Photos
//import MobileCoreServices
//import FloatRatingView
//
//@objc protocol PickerDelegate {
//    @objc optional func didSelectItem(at index: Int, item: String)
//    @objc optional func didSelectDate(date: Date)
//    @objc optional func didPickDocument(url: URL)
//}
//
//class BaseVC: UIViewController {
//
//    static var user: User!
//    var appDelegate = UIApplication.shared.delegate as! AppDelegate
//    var pickerView = UIPickerView()
//    var datePickerView = UIDatePicker()
//    var pickerTextfield : UITextField!
//    var pickerDelegate: PickerDelegate?
//    var pickerArray = [String]()
//    var imageDict: [String: Data]?
//    var videoDict: [String: Data]?
//    var imageDictCreatePost: [[String: Data]]?
//    var isChosenGallery: Bool = false
//    // To get current region
//    var currentCountry: String?
//    var toolBar = UIToolbar()
//    let searchTF = UITextField()
//
//    @IBInspectable var imageForEmptyScreen:UIImage = #imageLiteral(resourceName: "splash") {
//        didSet {
//            emptyview.imageView.image = imageForEmptyScreen
//        }
//    }
//    @IBInspectable var titleForEmptyScreen:String = "" {
//        didSet {
//            emptyview.titleLabel.text = titleForEmptyScreen
//        }
//    }
//    @IBInspectable var descriptionForEmptyScreen:String = "" {
//        didSet {
//            emptyview.descriptionLabel.text = descriptionForEmptyScreen
//        }
//    }
//
//
//    lazy var emptyview:EmptyScreenView = EmptyScreenView(image: self.imageForEmptyScreen, title: self.titleForEmptyScreen, description: self.descriptionForEmptyScreen)
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        navigationController?.navigationBar.barStyle = .black
//        getCurrentCountry()
//    }
//}
//
////MARK: Navigation Bar Methods
//extension BaseVC {
//
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
//
//    func setTitle(title: String, showBack: Bool = true, isLight: Bool = false, showGradient: Bool = false) {
//        self.navigationController?.isNavigationBarHidden = false
//        self.navigationController?.navigationBar.isHidden = false
//        if showGradient{
//            let image = self.navigationController?.navigationBar.setGradient(with: UIColor.CustomColor.darkBlue.color(), color2: UIColor.CustomColor.lightBlue.color())
//            self.navigationController?.navigationBar.setBackgroundImage(image, for: .default)
//        }else{
//            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
//        }
//
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//       // self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.navigationBar.layoutIfNeeded()
//       // self.navigationController?.navigationBar.transparentNavigationBar()
//        self.navigationController?.view.backgroundColor = .clear
//        if UIDevice.current.userInterfaceIdiom == .pad{
//            self.navigationController?.navigationBar.titleTextAttributes =
//                [NSAttributedString.Key.foregroundColor: isLight ? UIColor.black: UIColor.white,
//                 NSAttributedString.Key.font: UIFont.CustomFont.bold.font(size: 22.0)]
//        }else{
//            self.navigationController?.navigationBar.titleTextAttributes =
//                [NSAttributedString.Key.foregroundColor: isLight ? UIColor.black: UIColor.white,
//                 NSAttributedString.Key.font: UIFont.CustomFont.bold.font(size: 17.0)]
//        }
//        if let parent = self.parent, parent.isKind(of: UITabBarController.self) {
//            self.parent?.title = title
//        }
//        else {
//            self.title = title
//        }
//        if showBack {
//            self.setBackButton()
//        }
//        else {
//            if self.parent!.isKind(of: UITabBarController.self) {
//                self.parent!.navigationItem.leftBarButtonItem = nil
//                self.parent!.navigationItem.leftBarButtonItems = nil
//                self.parent!.navigationItem.hidesBackButton = true
//            }
//            else {
//                self.navigationItem.leftBarButtonItem = nil
//                self.navigationItem.leftBarButtonItems = nil
//                self.navigationItem.hidesBackButton = true
//            }
//        }
//    }
//
//    func hideNavigationBar() {
//        self.navigationController?.isNavigationBarHidden = true
//    }
//
//    func hideRightButton() {
//        if self.parent!.isKind(of: UITabBarController.self) {
//            self.parent!.navigationItem.rightBarButtonItem = nil
//            self.parent!.navigationItem.rightBarButtonItems = nil
//        }
//        else {
//            self.navigationItem.rightBarButtonItem = nil
//            self.navigationItem.rightBarButtonItems = nil
//        }
//    }
//
//    //MARK: Back Button
//    func setBackButton(image: UIImage =  #imageLiteral(resourceName: "white_arrow")){
//        let backButton = UIButton() //Custom back Button
//        backButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
//        backButton.setImage(image, for: .normal)
//        backButton.addTarget(self, action: #selector(self.backButtonAction), for: .touchUpInside)
//        let leftBarButton = UIBarButtonItem()
//        leftBarButton.customView = backButton
//        self.navigationItem.leftBarButtonItem = leftBarButton
//        if let parent = self.parent, parent.isKind(of: UITabBarController.self) {
//            self.parent!.navigationItem.setLeftBarButtonItems([leftBarButton], animated: false)
//        }
//        else {
//            self.navigationItem.setLeftBarButtonItems([leftBarButton], animated: false)
//        }
//    }
//
//    func setSearchBar(){
//        let rightView = UIView() //Custom Right View
//
//         var imageView = UIImageView()
//        imageView = UIImageView(frame: CGRect(x:8, y: 5, width: 60, height: 34))
//        imageView.image = #imageLiteral(resourceName: "white-logo")
//        imageView.contentMode = .scaleAspectFit
//        rightView.addSubview(imageView)
//
//        rightView.frame = CGRect(x: 68, y: 0, width: 260, height: 35)
//        rightView.backgroundColor = UIColor.white
//        rightView.set(radius: 8.0)
//        self.searchTF.becomeFirstResponder()
//        searchTF.text = ""
//        searchTF.frame = CGRect(x: 5, y: 0, width: 250, height: 30)
//        searchTF.center = rightView.center
//        searchTF.textColor = UIColor.black
//        searchTF.tintColor = UIColor.black
//
//        rightView.addSubview(searchTF)
//
//        let leftBarButton = UIBarButtonItem()
//        rightView.clipsToBounds = false
//        leftBarButton.customView = rightView
//        self.navigationItem.leftBarButtonItem = leftBarButton
//        if let parent = self.parent, parent.isKind(of: UITabBarController.self) {
//            self.parent!.navigationItem.setLeftBarButtonItems([leftBarButton], animated: false)
//        }
//        else {
//            self.navigationItem.setLeftBarButtonItems([leftBarButton], animated: false)
//        }
//    }
//
//    func setLeftView(image: URL?, name: String?, designation: String?){
//        let rightView = UIView() //Custom Right View
//        let width = (self.navigationController?.navigationBar.frame.size.width ?? 250)-105
//        rightView.frame = CGRect(x: 0, y: 0, width: width, height: 64)
//
//        var imageView = UIImageView()
//        var imageButton = UIButton()
//        var nameLabel = UILabel()
//        var designationLabel = UILabel()
//
//        if UIDevice.current.userInterfaceIdiom == .pad{
//            imageView = UIImageView(frame: CGRect(x: 2, y: 5, width: 70, height: 40))
//            imageButton = UIButton(frame: CGRect(x: 5, y: 5, width: 170, height: 40))
//            nameLabel = UILabel(frame: CGRect(x: 55, y: 0, width: 200, height: 30))
//            designationLabel = UILabel(frame: CGRect(x: 55, y: 20, width: 200, height: 30))
//           // imageView.set(radius: 20.0)
//            nameLabel.font = UIFont.CustomFont.regular.font(size: 20.0)
//            designationLabel.font = UIFont.CustomFont.regular.font(size: 18.0)
//        }else{
//            imageView = UIImageView(frame: CGRect(x:2, y: 0, width: 75, height: 40))
//            imageButton = UIButton(frame: CGRect(x: 10, y: 5, width: 170, height: 34))
//            nameLabel = UILabel(frame: CGRect(x: 57, y: 6, width: 200, height: 20))
//            designationLabel = UILabel(frame: CGRect(x: 57, y: 22, width: 300, height: 20))
//            //imageView.set(radius: imageView.half)
//            nameLabel.font = UIFont.CustomFont.regular.font(size: 15.0)
//            designationLabel.font = UIFont.CustomFont.regular.font(size: 12.0)
//        }
//        imageView.image = #imageLiteral(resourceName: "white-logo")
//       // imageButton.addTarget(self, action: #selector(openProfile), for: .touchUpInside)
//
////        let placeHolderImage =  #imageLiteral(resourceName: "userWhitePlaceholder")
////        imageView.sd_setImage(with: image, placeholderImage: placeHolderImage, options: .refreshCached, context: nil)
//
//        imageView.contentMode = .scaleAspectFit
//
//        rightView.addSubview(imageView)
//       // rightView.addSubview(imageButton)
//
//        nameLabel.text = name
//        nameLabel.textColor = UIColor.white
//
//       //rightView.addSubview(nameLabel)
//
//        designationLabel.text = designation
//        designationLabel.textColor = UIColor.white
//
//      //  rightView.addSubview(designationLabel)
//
//        rightView.set(radius: 8.0)
//
//        let searchView = UIView()
//        let searchWidth = width - (80)
//        searchView.frame = CGRect(x: 85, y: 6, width: searchWidth, height: 28)
//        searchView.set(radius: 6.0)
//        searchView.backgroundColor = UIColor.white
//        //        self.searchTF.becomeFirstResponder()
//        //        searchTF.text = ""
//        searchTF.frame = CGRect(x: 5, y: 2, width: 180, height: 28)
//        searchTF.textAlignment = .left
//        searchTF.textColor = UIColor.black
//        searchTF.font = UIFont.init(name: "Helvetica Neue", size: 13)
//        searchTF.tintColor = UIColor.black
//
//        searchTF.keyboardAppearance = .light
//        searchView.addSubview(searchTF)
//        rightView.addSubview(searchView)
//
//        let leftBarButton = UIBarButtonItem()
//        rightView.clipsToBounds = false
//        leftBarButton.customView = rightView
//        self.navigationItem.leftBarButtonItem = leftBarButton
//        if let parent = self.parent, parent.isKind(of: UITabBarController.self) {
//            self.parent!.navigationItem.setLeftBarButtonItems([leftBarButton], animated: false)
//        }
//        else {
//            self.navigationItem.setLeftBarButtonItems([leftBarButton], animated: false)
//        }
//    }
//
//    @objc func backButtonAction() {
//        let navObj = self.navigationController?.popViewController(animated: true)
//        if navObj == nil {
//            self.navigationController?.dismiss(animated: true, completion: nil)
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
//
//    @objc func openProfile(){
//      //  let storyboard = UIStoryboard.storyboard(storyboard: .Profile)
//        //let profileVC = storyboard.instantiateViewController(withIdentifier: kNewProfilePage) as! NewProfilePageVC
//       // profileVC.userId = DataManager.id
//        //profileVC.comeFrom = DataManager.userType ?? ""
//       // self.navigationController?.pushViewController(profileVC, animated: true)
//    }
//
//    //MARK: Right Buttton
//    func setRightButton(image: UIImage? = nil, title: String? = nil){
//
//        let backButton = UIButton() //Custom back Button
//        backButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
//        backButton.tintColor = UIColor.white
//        if title != nil {
//            backButton.setTitle(title, for: .normal)
//            backButton.setTitleColor(UIColor.white, for: .normal)
//            if UIDevice.current.userInterfaceIdiom == .pad{
//                backButton.titleLabel?.font = UIFont.CustomFont.regular.font(size: 20.0)
//            }else{
//                backButton.titleLabel?.font = UIFont.CustomFont.regular.font()
//            }
//
//        }
//        else {
//            backButton.setImage(image, for: .normal)
//        }
//        backButton.addTarget(self, action: #selector(self.rightButtonAction(sender:)), for: .touchUpInside)
//        let rightBarButton = UIBarButtonItem()
//        rightBarButton.customView = backButton
//        self.navigationItem.rightBarButtonItem = rightBarButton
//        let negativeSpacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
//        negativeSpacer.width = -10;
//
//        if let parent = self.parent, parent.isKind(of: UITabBarController.self) {
//            self.parent!.navigationItem.setRightBarButtonItems([rightBarButton, negativeSpacer], animated: false)
//        }
//        else {
//            self.navigationItem.setRightBarButtonItems([rightBarButton, negativeSpacer], animated: false)
//        }
//    }
//
//    func setRightBarButtons(first:UIImage,second:UIImage){
//        let firstButton = UIButton() //Custom first Button
//        firstButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
//        firstButton.setImage(first, for: .normal)
//        firstButton.tintColor = UIColor.white
//
//        let secondButton = UIButton() //Custom second Button
//        secondButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
//        secondButton.setImage(second, for: .normal)
//        secondButton.tintColor = UIColor.white
//
//
//        firstButton.addTarget(self, action: #selector(self.rightButtonAction(sender:)), for: .touchUpInside)
//        secondButton.addTarget(self, action: #selector(self.rightSecondButtonAction(sender:)), for: .touchUpInside)
//        let rightBarButton = UIBarButtonItem()
//        rightBarButton.customView = firstButton
//
//        let rightSecondBarButton = UIBarButtonItem()
//        rightSecondBarButton.customView = secondButton
//
//        self.navigationItem.rightBarButtonItems = [rightBarButton,rightSecondBarButton]
//
//        if let parent = self.parent, parent.isKind(of: UITabBarController.self) {
//            self.parent!.navigationItem.setRightBarButtonItems([rightBarButton,rightSecondBarButton], animated: false)
//        }
//        else {
//            self.navigationItem.setRightBarButtonItems([rightBarButton,rightSecondBarButton], animated: false)
//        }
//    }
//
//    func setRightHomeBarButtons(first:UIImage,second:UIImage){
//        let firstButton = UIButton() //Custom first Button
//        firstButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
//        firstButton.setImage(first, for: .normal)
//        firstButton.tintColor = UIColor.white
//
//        let secondButton = UIButton() //Custom second Button
//        secondButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
//        secondButton.setImage(second, for: .normal)
//        secondButton.tintColor = UIColor.white
//
//
//        firstButton.addTarget(self, action: #selector(self.rightButtonAction(sender:)), for: .touchUpInside)
//        secondButton.addTarget(self, action: #selector(self.rightSecondButtonAction(sender:)), for: .touchUpInside)
//        let stackview = UIStackView.init(arrangedSubviews: [secondButton,firstButton])
//        stackview.distribution = .equalSpacing
//        stackview.axis = .horizontal
//        stackview.alignment = .center
//        stackview.spacing = 12
//
//        let rightBarButton = UIBarButtonItem(customView: stackview)
//        self.navigationItem.rightBarButtonItem = rightBarButton
//
//        if let parent = self.parent, parent.isKind(of: UITabBarController.self) {
//            self.parent!.navigationItem.setRightBarButtonItems([rightBarButton], animated: false)
//        }
//        else {
//            self.navigationItem.setRightBarButtonItems([rightBarButton], animated: false)
//        }
//    }
//
//    @objc func rightButtonAction(sender: UIButton) {
//
//    }
//
//    @objc func rightSecondButtonAction(sender: UIButton){
//
//    }
//
//     //MARK: Custom Date Picker
//       func setDatePicker(textField: UITextField, datePickerMode: UIDatePicker.Mode = .dateAndTime, maximunDate: Date? = nil, minimumDate: Date? = nil) {
//           textField.inputView = datePickerView
//           pickerTextfield = textField
//           datePickerView.datePickerMode = datePickerMode
//           if #available(iOS 13.4, *) {
//            datePickerView.preferredDatePickerStyle = .wheels
//           } else {
//            // Fallback on earlier versions
//           }
//           datePickerView.timeZone = NSTimeZone.local
//           datePickerView.backgroundColor = UIColor.lightGray
//           datePickerView.maximumDate = maximunDate
//           datePickerView.minimumDate = minimumDate
//           textField.text = datePickerView.date.string(format: .dmyDate2, type: .local)
//           datePickerView.addTarget(self, action: #selector(self.didDatePickerViewValueChanged(sender:)), for: .valueChanged)
//       }
//
//    @objc func didDatePickerViewValueChanged(sender: UIDatePicker) {
//        pickerTextfield.text = sender.date.string(format: .dmyDate2, type: .local)
//        NotificationCenter.default.post(name: NSNotification.Name("calculateDays"), object: nil)
//        pickerDelegate?.didSelectDate?(date: sender.date)
//    }
//
////    func logout() {
////        OnboardingVM.shared.logout { (message, error) in
////            if error != nil {
////                DataManager.accessToken = nil
////                let storyboard = UIStoryboard.storyboard(storyboard: .Main)
////                let vc = storyboard.instantiateViewController(withIdentifier: kLoginVC) as! LoginVC
////                let navigationController = UINavigationController(rootViewController: vc)
////                UIApplication.shared.keyWindow?.rootViewController = navigationController
////            }
////            else {
////                DataManager.accessToken = nil
////                let storyboard = UIStoryboard.storyboard(storyboard: .Main)
////                let vc = storyboard.instantiateViewController(withIdentifier: kLoginVC) as! LoginVC
////                let navigationController = UINavigationController(rootViewController: vc)
////                UIApplication.shared.keyWindow?.rootViewController = navigationController
////            }
////        }
////    }
//
//    //MARK: Empty Screen Implementation
//    func showEmptyScreen(belowSubview subview: UIView? = nil, superView:UIView? = nil) {
//        let baseView: UIView = superView ?? self.view
//        emptyview.frame = CGRect(x: 0, y: 0, width: baseView.frame.width, height: baseView.frame.height)
//        if let subview = subview {
//            baseView.insertSubview(emptyview, belowSubview: subview)
//        }
//        else {
//            baseView.addSubview(emptyview)
//        }
//    }
//
//    func hideEmptyScreen() {
//        emptyview.removeFromSuperview()
//    }
//}
//
////MARK: Alert Methods
//extension BaseVC {
//
//    func showAlert(title:String? = nil, message: String?, cancelTitle: String? = nil,  cancelAction: ButtonAction? = nil, okayTitle: String = kOkay, _ okayAction: ButtonAction? = nil,showTF:Bool? = nil, showImage:Bool? = nil,image:UIImage = #imageLiteral(resourceName: "tick")) {
//        let alert = CustomAlert(title: title, message: message, cancelButtonTitle: cancelTitle, doneButtonTitle: okayTitle,image: image,showImage: showImage ?? true,showTF: showTF ?? true)
//        alert.cancelButton.addTarget {
//            cancelAction?()
//            alert.remove()
//        }
//        alert.doneButton.addTarget {
//            okayAction?()
//            alert.remove()
//        }
//        alert.show()
//    }
//
//    func showCustomAlert(message: String?){
//        let alert = CustomAlert(title: "Success", message: message)
//        alert.cancelButton.addTarget {
//            alert.remove()
//        }
//        alert.doneButton.addTarget {
//            alert.remove()
//        }
//        alert.show()
//    }
//
//    func showFilter() {
//        let alert = FilterAlert()
//        alert.cancelButton.addTarget {
//            alert.remove()
//        }
//        alert.doneButton.addTarget {
//            alert.remove()
//        }
//        alert.show()
//    }
//
//
//    func showErrorMessage(error: Error?, okayAction: ButtonAction? = nil) {
//        /*
//         STATUS CODES:
//         200: Success (If request sucessfully done and data is also come in response)
//         204: No Content (If request successfully done and no data is available for response)
//         401: Unautorized (If token got expired)
//         402: Block (If User blocked by admin)
//         403: Delete (If User deleted by admin)
//         406: Not Acceptable (If user is registered with the application but not verified)
//         */
//        let message = (error as NSError?)?.userInfo[APIKeys.kMessage] as? String ?? kErrorAlert
//        let alert = CustomAlert(title: kError, message: message, cancelButtonTitle: nil, doneButtonTitle: kOkay, image: #imageLiteral(resourceName: "error"))
//        alert.doneButton.addTarget {
//            alert.remove()
//            okayAction?()
//            let code = (error! as NSError).code
//            if code == 402 || code == 403 || code == 401 {
//                self.logout()
//            }
//        }
//        alert.show()
//    }
//
//    func logout(){
//        DataManager.loginStatus = false
//        let storyboard = UIStoryboard.storyboard(storyboard: .Main)
//        let loginvc = storyboard.instantiateViewController(withIdentifier: kLoginVC) as! LoginVC
//        let nav = UINavigationController(rootViewController: loginvc)
//        UIApplication.shared.windows.first?.rootViewController = nav
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
//    }
//
//    func openSettings() {
//        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
//            return
//        }
//        if UIApplication.shared.canOpenURL(settingsUrl) {
//            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
//                print("Settings opened: \(success)")
//            })
//        }
//    }
//
//    static func getTimerComponents(saleEndTime: String) -> (min: Int, second: Int) {
//        var hours = 00
//        var minute = 00
//        var sec = 00
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "mm:ss"
//        if let date = dateFormatter.date(from: saleEndTime) {
//            let calendar = Calendar.current
//            let comp = calendar.dateComponents([.minute, .second], from: date)
//            hours = comp.hour ?? 00
//            minute = comp.minute ?? 00
//            sec = comp.second ?? 00
//        }
//        else {
//            let durationArray = saleEndTime.split(separator: ".")
//            if durationArray.count > 0 {
//                let hour = Int(durationArray[0]) ?? 0
//                var min = 0
//                if durationArray.count > 1 {
//                    min = Int(durationArray[1]) ?? 0
//                    if min > 0 {
//                        min = 30
//                    }
//                }
//                return (min, 0)
//            }
//        }
//        return (minute, sec)
//    }
//}
//
////MARK: Set Data Pickers DataSource and Delegate Methods
//extension BaseVC: UIPickerViewDelegate , UIPickerViewDataSource {
//
//    //MARK: Custom Picker Methods
//    func setPickerView(textField: UITextField, array: [String],checkAcademic:Bool? = false) {
//        pickerView.delegate = self
//        pickerView.dataSource = self
//        pickerArray = array
//        pickerTextfield = textField
//
//        //Set Picker View to Textfield
//
//        textField.inputView = pickerView
//        if !checkAcademic!{
//            textField.text = pickerArray.first
//        }
//        pickerView.reloadAllComponents()
//        pickerView.selectRow(0, inComponent: 0, animated: false)
//    }
//
//    @objc func onDoneButtonTapped() {
//        toolBar.removeFromSuperview()
//        pickerView.removeFromSuperview()
//    }
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerArray.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return pickerArray[row]
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        pickerDelegate?.didSelectItem?(at: row, item: pickerArray[row])
//        self.pickerTextfield.text = pickerArray[row]
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updatePin"), object: nil)
//    }
//}
//
////MARK: Show image picker
//extension BaseVC : UIPopoverPresentationControllerDelegate{
//
//    func showImagePicker(showVideo: Bool = false, showDocument: Bool = false) {
//        let alert  = UIAlertController(title: "SELECT MEDIA", message: nil, preferredStyle: .actionSheet)
//        alert.addAction(UIAlertAction(title: "GALLERY", style: .default, handler: {action in
//            let photos = PHPhotoLibrary.authorizationStatus()
//            if photos == .notDetermined || photos == .denied || photos == .restricted {
//                PHPhotoLibrary.requestAuthorization({status in
//                    DispatchQueue.main.async {
//                        if status == .authorized {
//                            CustomImagePickerView.sharedInstace.pickImageUsing(target: self, mode: .gallery, showVideo: showVideo)
//                        }
//                        else {
//                            self.showAlert(message: "Please enable the photo library permission from the settings.", {
//                                 self.openSettings()
//                            })
//                            return
//                        }
//                    }
//                })
//            }
//            else {
//                CustomImagePickerView.sharedInstace.pickImageUsing(target: self, mode: .gallery, showVideo: showVideo)
//            }
//        }))
//        alert.addAction(UIAlertAction(title: "CAMERA", style: .default, handler: {action in
//            AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
//                self.isChosenGallery = false
//                DispatchQueue.main.async {
//                    if response {
//                        CustomImagePickerView.sharedInstace.pickImageUsing(target: self, mode: .camera, showVideo: showVideo)
//                    } else {
//                        self.showAlert(message: "Please enable the camera permission from the settings.", {
//                            self.openSettings()
//                        })
//                        return
//                    }
//                }
//            }
//        }))
//        if showDocument {
//            alert.addAction(UIAlertAction(title: "DOCUMENT", style: .default, handler: {action in
//                let types = [kUTTypePDF]
//                let importMenu = UIDocumentPickerViewController(documentTypes: types as [String], in: .import)
//                importMenu.allowsMultipleSelection = false
//                importMenu.delegate = self as! UIDocumentPickerDelegate
//                importMenu.modalPresentationStyle = .formSheet
//                self.present(importMenu, animated: true, completion: nil)
//            }))
//        }
//        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
//        if UIDevice.current.userInterfaceIdiom == .pad{
//            alert.popoverPresentationController?.sourceView = self.view
//            alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: 270, width: 1, height: 1)
//            alert.popoverPresentationController?.permittedArrowDirections = []
//        }
//        self.present(alert, animated: true, completion: nil)
//    }
//
//   @objc func openGallery() {
//    isChosenGallery = true
//        let photos = PHPhotoLibrary.authorizationStatus()
//        if photos == .notDetermined || photos == .denied || photos == .restricted {
//            PHPhotoLibrary.requestAuthorization({status in
//                DispatchQueue.main.async {
//                    if status == .authorized {
//                        CustomImagePickerView.sharedInstace.pickImageUsing(target: self, mode: .gallery)
//                    }
//                    else {
//                        self.showAlert(message: "Please enable the library permission from the settings.", {
//                            self.openSettings()
//                        })
//                        return
//                    }
//                }
//            })
//        }
//        else {
//            CustomImagePickerView.sharedInstace.pickImageUsing(target: self, mode: .gallery)
//        }
//    }
//
//    func getThumbnailFromDispatch(path: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
//        DispatchQueue.global().async {
//            do {
//                let asset = AVURLAsset(url: path , options: nil)
//                let imgGenerator = AVAssetImageGenerator(asset: asset)
//                imgGenerator.appliesPreferredTrackTransform = true
//                let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
//                let thumbnail = UIImage(cgImage: cgImage)
//                DispatchQueue.main.async {
//                    completion(thumbnail)
//                }
//            } catch let error {
//                print("*** Error generating thumbnail: \(error.localizedDescription)")
//                DispatchQueue.main.async {
//                    completion(nil)
//                }
//            }
//        }
//    }
//
//    func getThumbnailFrom(path: URL) -> UIImage? {
//        do {
//            let asset = AVURLAsset(url: path , options: nil)
//            let imgGenerator = AVAssetImageGenerator(asset: asset)
//            imgGenerator.appliesPreferredTrackTransform = true
//            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
//            let thumbnail = UIImage(cgImage: cgImage)
//            return thumbnail
//        } catch let error {
//            print("*** Error generating thumbnail: \(error.localizedDescription)")
//            return nil
//        }
//    }
//
//    @objc func shareText(message: String) {
//        let activityViewController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
//        activityViewController.popoverPresentationController?.sourceView = self.view
//        self.present(activityViewController, animated: true, completion: nil)
//    }
//
//}
//
//extension BaseVC{
//
//    func getCurrentCountry(){
//        let countryLocale = NSLocale.current
//        let countryCode = countryLocale.regionCode
//        var country = (countryLocale as NSLocale).displayName(forKey: NSLocale.Key.countryCode, value: countryCode)
//        if country == "United States" {
//            country  = "USA"
//        }
//       // DataManager.currentCountry = country ?? ""
//        currentCountry = country ?? ""
//    }
//}
//
//extension UINavigationBar {
//    func transparentNavigationBar() {
////    self.setBackgroundImage(UIImage(), for: .default)
////    self.shadowImage = UIImage()
//    self.isTranslucent = true
//    }
//}
//
