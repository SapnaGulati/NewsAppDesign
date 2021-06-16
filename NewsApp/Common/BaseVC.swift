//
//  BaseVC.swift
//  DT MedNet
//
//  Created by IOS on 23/09/19.
//  Copyright © 2019 Deftsoft. All rights reserved.
//

import UIKit
import AVFoundation
import CoreLocation
import MapKit
var skipNotificationAlert = false
var skipLocationPermission = false
 var enableMonitoring: Bool!
class BaseVC: UIViewController{
    
    //MARK:- Variables
   // static var user: User!
    static var shared = BaseVC()
    var locationManager = CLLocationManager()
   
    
    var counter = 0
    var appDelegate = UIApplication.shared.delegate as? AppDelegate
    let EnteredRegionMessageNotificationId = "EnteredRegionNotification"
    var latitude: Double?
    var longitude: Double?
    var counterState: Bool = false
    
    //MARK:- Class Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        debugPrint("********** MEMORY WARNING **********")
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.memoryCapacity = 0
        URLCache.shared.diskCapacity = 0
    }
}

//MARK:- Navigation Methods
extension BaseVC {
    func hideNavigationBar() {
//        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationController?.isNavigationBarHidden = true
//        UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
        
    }
    
    //MARK:- Navigation Title
//    func set(title:String, showBack: Bool = true, showMenuButton:Bool = false) {
//
//        self.navigationController?.isNavigationBarHidden = false
//        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.navigationBar.barTintColor = UIColor.AppColor.navBarColor.color()
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.barStyle = UIBarStyle.blackOpaque
//        self.navigationController?.navigationBar.setBackgroundImage(UIColor.clear.as1ptImage(), for: .any, barMetrics: .default)
//        self.navigationController?.navigationBar.shadowImage = UIColor.clear.as1ptImage()
//        let titleButton = UIButton(frame: CGRect(x: 50, y:0, width:110, height:30))
//        titleButton.titleLabel?.textAlignment = .center
//        titleButton.setTitle(title, for: .normal)
//        titleButton.isUserInteractionEnabled = false
//        titleButton.titleEdgeInsets = UIEdgeInsets(top: 3, left: 0, bottom: 7, right: 0)
//        titleButton.setTitleColor(UIColor.AppColor.titleColor.color(), for: .normal)
//        titleButton.titleLabel?.font = UIFont.CustomFont.bold.fontWithSize(size: 20.0)
//        self.navigationItem.titleView = titleButton
//        if showBack {
//            self.setBackButton()
//        }
//        else {
//            self.navigationItem.hidesBackButton = true
//        }
//        if showMenuButton {
//            self.setMenuButton()
//        }
//    }
//
//    //MARK:- Back Button
//    func setBackButton(){
//        let backButton = UIButton()
//        backButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
//        backButton.setImage(#imageLiteral(resourceName: "BackArrow"), for: UIControl.State.normal)
//        backButton.addTarget(self, action: #selector(self.backButtonAction), for: UIControl.Event.touchUpInside)
//        backButton.contentEdgeInsets = UIEdgeInsets(top: -10, left: -20, bottom: 0, right: 0)
//        let leftBarButton = UIBarButtonItem()
//        leftBarButton.customView = backButton
//        self.navigationItem.leftBarButtonItem = leftBarButton
//    }
//
//    @objc func backButtonAction() {
//        self.view.endEditing(true)
//        let backDone = self.navigationController?.popViewController(animated: true)
//        if backDone == nil {
//            self.navigationController?.dismiss(animated: true, completion: nil)
//        }
//    }
//
//    //MARK: Side Menu
//     func setMenuButton() {
//        let menuButton = UIButton()
//        menuButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
//        menuButton.setImage(#imageLiteral(resourceName: "Menu"), for: UIControl.State.normal)
//        menuButton.addTarget(self, action: #selector(self.menuButtonAction), for: UIControl.Event.touchUpInside)
//        menuButton.contentEdgeInsets = UIEdgeInsets(top: -10, left: -10 , bottom: 0, right: 0)
//        let leftBarButton = UIBarButtonItem()
//        leftBarButton.customView = menuButton
//        self.navigationItem.leftBarButtonItem = leftBarButton
//
//    }
//    @objc  func menuButtonAction(){
//       openSideMenu()
//    }
//
//
//     func verifyUrl (urlString: String?) -> Bool {
//        //Check for nil
//        if let urlString = urlString {
//            // create NSURL instance
//            if let url = URL(string: urlString) {
//                // check if your application can open the NSURL instance
//                return UIApplication.shared.canOpenURL(url)
//            }
//        }
//        return false
//    }
//
}
//
////MARK:- Other Functions
//extension BaseVC {
//    func openSideMenu(){
//        appDelegate?.sideMenu?.revealMenu()
//    }
//    func loadLeftSideMenu(){
//        appDelegate?.loadSideMenu()
//    }
//    func navigateToLoginPage(){
//        appDelegate?.navigateToLogin()
//}
//    func logoutFromApp(){
//        showCustomAlert(title: "Logout", message: "Are You Sure to Log Out ?", cancelButtonTitle: "Cancel", doneButtonTitle: "Yes", cancelCallback: {
//            print("removed")
//        }) {
//            self.callApiToLogout()
//        }
//    }
//
//    func isLocationAccessEnabled() {
//          if CLLocationManager.locationServicesEnabled() {
//             switch CLLocationManager.authorizationStatus() {
//                case .notDetermined, .restricted, .denied:
//             showCustomAlert(title: "Location", message: "Please enable location permissions in settings.", cancelButtonTitle: "No thanks", doneButtonTitle: "Open Settings", cancelCallback: {
//                        skipLocationPermission = true
//                    }) {
//                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
//                    }
//
//             case .authorizedAlways, .authorizedWhenInUse:
//                 print("authorised")
//
//             }
//          } else {
//           showCustomAlert(title: "Location", message: "Please enable location permissions in settings.", cancelButtonTitle: "No thanks", doneButtonTitle: "Open Settings", cancelCallback: {
//            //   skipLocationPermission = true
//           }) {
//               UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
//           }
//          }
//       }
//
//}


// MARK:- Custom Alert Methods
extension BaseVC {
    func showCustomAlert(title: String? = kSuccess, message: String?,cancelButtonTitle: String? = nil, doneButtonTitle: String? = kOkay,cancelCallback: (() ->())? = nil,  doneCallback: (() ->())? = nil) {
        let customAlert = CustomAlert(title: title, message: message, cancelButtonTitle: cancelButtonTitle, doneButtonTitle: doneButtonTitle)

        customAlert.doneButton.addTarget(for: .touchUpInside) {
            if doneCallback != nil { doneCallback!()}
            customAlert.remove()
        }

        customAlert.cancelButton.addTarget(for: .touchUpInside) {

            if cancelCallback != nil { cancelCallback!()}
            customAlert.remove()
        }

        customAlert.show()
    }

    func showErrorMessage(error: Error?) {
        /*
         STATUS CODES:
         200: Success (If request sucessfully done and data is also come in response)
         204: No Content (If request successfully done and no data is available for response)
         401: Unauthorized (If token got expired)
         402: Block (If User blocked by admin)
         403: Delete (If User deleted by admin)
         406: Not Acceptable (If user is registered with the application but not verified)
         */
        let message = (error! as NSError).userInfo[APIKeys.kMessage] as? String ?? kSomethingWentWrong
        self.showCustomAlert(title: kError, message: message, cancelButtonTitle: nil) {
            //ok button action
            let code = (error! as NSError).code
            if code == 401 || code == 402 || code == 403 || code == 406 {
                enableMonitoring = false
            }
        }
    }


}
//
//// To Display view in landscape mode when device rotates
//extension BaseVC {
//
//    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        super.traitCollectionDidChange(previousTraitCollection)
//        switch UIDevice.current.orientation{
//        case .portrait:
//            print("POTRAIT")
//            dismiss(animated: true)
//        case .landscapeLeft,.landscapeRight:
//            print("LANDSCAPE")
//            let vc = LandscapeVC.instance
//            vc.modalTransitionStyle = .crossDissolve
//            vc.modalPresentationStyle = .overCurrentContext
//            navigationController?.present(vc, animated: true)
//        default:
//            break
//        }
//    }
//}
//
//
////MARK:- API's
//extension BaseVC{
//    func callApiToLogout(){
//        UserVM.shared.callApiForLogout{ (message, error) in
//            if error != nil {
//                self.showErrorMessage(error: error)
//            }else {
//                self.locationManager.stopUpdatingLocation()
//                DataManager.accessToken = ""
////                for region in self.locationManager.monitoredRegions {
////                    print(region)
////                    self.locationManager.stopMonitoring(for: region)
////                }
//                enableMonitoring = false
//                DataManager.notificationStatus = nil
//                NotificationVM.shared.notificationListing.removeAll()
//                self.navigateToLoginPage()
//
//
//            }
//        }
//    }
//}
//
//extension BaseVC: CLLocationManagerDelegate {
//
//    func zoomToUserLocation( mapView: MKMapView) {
//        latitude = locationManager.location?.coordinate.latitude
//        longitude = locationManager.location?.coordinate.longitude
//        let userLocationCenter = CLLocationCoordinate2D(latitude: latitude ?? 0, longitude: longitude ?? 0)
//        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
//        let mapRegion = MKCoordinateRegion(center: userLocationCenter, span: span)
//        mapView.setRegion(mapRegion, animated: true)
//    }
//
//
//    func setupLocationManager() {
//        if CLLocationManager.authorizationStatus() == .authorizedAlways {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.startUpdatingLocation()
//            locationManager.allowsBackgroundLocationUpdates = true
//        }
//
//
//   //     locationManager.startUpdatingLocation()
//    }
//
//    func geoFencingForHomeVC() {
//        self.latitude = self.locationManager.location?.coordinate.latitude
//        self.longitude = self.locationManager.location?.coordinate.longitude
//        print(self.latitude ?? 0)
//        print(self.longitude ?? 0)
//
//
//        let lati = SideMenuListVM.shared.geoFencingData?.latitude ?? ""
//        let longi = SideMenuListVM.shared.geoFencingData?.longitude ?? ""
//        let businessLat = (lati as NSString).doubleValue
//        let businessLong = (longi as NSString).doubleValue
//        let destination = CLLocation(latitude: businessLat, longitude: businessLong)
//        let current = CLLocation(latitude: self.latitude ?? 0, longitude: self.longitude ?? 0)
//        let radiusDistance = current.distance(from: destination)
//        let distanceMeters = Measurement(value: radiusDistance, unit: UnitLength.meters)
//        let miles = distanceMeters.converted(to: UnitLength.miles).value.roundValue
//        print(miles)
//        if miles <= 3 {
//            let geofenceRegionCenter =  CLLocationCoordinate2DMake(businessLat ,businessLong)
//            let circularRegion = CLCircularRegion.init(center: geofenceRegionCenter,
//                                                       radius: SideMenuListVM.shared.geoFencingData?.geoFencingRadius ?? 0.0,
//                                                       identifier: "Beaver Deals")
//            circularRegion.notifyOnEntry = true
//            circularRegion.notifyOnExit = false
//            locationManager.startMonitoring(for: circularRegion)
//
//        }
//        else {
//            let geofenceRegionCenter =  CLLocationCoordinate2DMake(businessLat ,businessLong)
//            let circularRegion = CLCircularRegion.init(center: geofenceRegionCenter,
//                                                       radius: SideMenuListVM.shared.geoFencingData?.geoFencingRadius ?? 0.0,
//                                                       identifier: "Beaver Deals")
//            locationManager.stopMonitoring(for: circularRegion)
//        }
//    }
//
//
//    func setUpGeofenceForAllScreens() {
//
//        // GeoFencing For HomeVC
//        geoFencingForHomeVC()
//
//        for business in SideMenuListVM.shared.businessListing {
//            self.latitude = self.locationManager.location?.coordinate.latitude
//            self.longitude = self.locationManager.location?.coordinate.longitude
//            print(self.latitude ?? 0)
//            print(self.longitude ?? 0)
//
//
//            let lati = business.latitude ?? ""
//            let longi = business.longitude ?? ""
//            let businessLat = (lati as NSString).doubleValue
//            let businessLong = (longi as NSString).doubleValue
//            let destination = CLLocation(latitude: businessLat, longitude: businessLong)
//            let current = CLLocation(latitude: self.latitude ?? 0, longitude: self.longitude ?? 0)
//            let radiusDistance = current.distance(from: destination)
//            let distanceMeters = Measurement(value: radiusDistance, unit: UnitLength.meters)
//            let miles = distanceMeters.converted(to: UnitLength.miles).value.roundValue
//            print(miles)
//            if miles <= 3 {
//                let geofenceRegionCenter =  CLLocationCoordinate2DMake(businessLat ,businessLong)
//                let circularRegion = CLCircularRegion.init(center: geofenceRegionCenter,
//                                                           radius: business.geoFencingRadius ?? 0.0,
//                                                           identifier: business.name ?? "")
//                circularRegion.notifyOnEntry = true
//                circularRegion.notifyOnExit = false
//                locationManager.startMonitoring(for: circularRegion)
//
//            }
//            else {
//                let geofenceRegionCenter =  CLLocationCoordinate2DMake(businessLat ,businessLong)
//                let circularRegion = CLCircularRegion.init(center: geofenceRegionCenter,
//                                                           radius: business.geoFencingRadius ?? 0.0,
//                                                           identifier: business.name ?? "")
//                locationManager.stopMonitoring(for: circularRegion)
//            }
//
//        }
//
//        for discount in SideMenuListVM.shared.discountListing {
//            self.latitude = self.locationManager.location?.coordinate.latitude
//            self.longitude = self.locationManager.location?.coordinate.longitude
//            print(self.latitude ?? 0)
//            print(self.longitude ?? 0)
//
//
//            let lati = discount.latitude ?? ""
//            let longi = discount.longitude ?? ""
//            let discountLat = (lati as NSString).doubleValue
//            let discountLong = (longi as NSString).doubleValue
//            let destination = CLLocation(latitude: discountLat, longitude: discountLong)
//            let current = CLLocation(latitude: self.latitude ?? 0, longitude: self.longitude ?? 0)
//            let radiusDistance = current.distance(from: destination)
//            let distanceMeters = Measurement(value: radiusDistance, unit: UnitLength.meters)
//            let miles = distanceMeters.converted(to: UnitLength.miles).value.roundValue
//            print(miles)
//            if miles <= 3 {
//                let geofenceRegionCenter =  CLLocationCoordinate2DMake(discountLat ,discountLong)
//                let circularRegion = CLCircularRegion.init(center: geofenceRegionCenter,
//                                                           radius: discount.geoFencingRadius ?? 0.0,
//                                                           identifier: discount.discount_business_name ?? "")
//                circularRegion.notifyOnEntry = true
//                circularRegion.notifyOnExit = false
//                locationManager.startMonitoring(for: circularRegion)
//
//            }
//            else {
//                let geofenceRegionCenter =  CLLocationCoordinate2DMake(discountLat ,discountLong)
//                let circularRegion = CLCircularRegion.init(center: geofenceRegionCenter,
//                                                           radius: discount.geoFencingRadius ?? 0.0,
//                                                           identifier: discount.discount_business_name ?? "")
//                locationManager.stopMonitoring(for: circularRegion)
//            }
//        }
//
//        for historical in SideMenuListVM.shared.historical {
//            self.latitude = self.locationManager.location?.coordinate.latitude
//            self.longitude = self.locationManager.location?.coordinate.longitude
//            print(self.latitude ?? 0)
//            print(self.longitude ?? 0)
//
//
//            let lati = historical.latitude ?? ""
//            let longi = historical.longitude ?? ""
//            let historicalLat = (lati as NSString).doubleValue
//            let historicalLong = (longi as NSString).doubleValue
//            let destination = CLLocation(latitude: historicalLat, longitude: historicalLong)
//            let current = CLLocation(latitude: self.latitude ?? 0, longitude: self.longitude ?? 0)
//            let radiusDistance = current.distance(from: destination)
//            let distanceMeters = Measurement(value: radiusDistance, unit: UnitLength.meters)
//            let miles = distanceMeters.converted(to: UnitLength.miles).value.roundValue
//            print(miles)
//            if miles <= 3 {
//                let geofenceRegionCenter =  CLLocationCoordinate2DMake(historicalLat ,historicalLong)
//                let circularRegion = CLCircularRegion.init(center: geofenceRegionCenter,
//                                                           radius: historical.geoFencingRadius ?? 0.0,
//                                                           identifier: historical.name ?? "")
//                circularRegion.notifyOnEntry = true
//                circularRegion.notifyOnExit = false
//                locationManager.startMonitoring(for: circularRegion)
//
//            }
//            else {
//                let geofenceRegionCenter =  CLLocationCoordinate2DMake(historicalLat ,historicalLong)
//                let circularRegion = CLCircularRegion.init(center: geofenceRegionCenter,
//                                                           radius: historical.geoFencingRadius ?? 0.0,
//                                                           identifier: historical.name ?? "")
//                locationManager.stopMonitoring(for: circularRegion)
//            }
//        }
//
//        for golden in SideMenuListVM.shared.goldenBeaverListing {
//            self.latitude = self.locationManager.location?.coordinate.latitude
//            self.longitude = self.locationManager.location?.coordinate.longitude
//            print(self.latitude ?? 0)
//            print(self.longitude ?? 0)
//
//            let lati = golden.latitude ?? ""
//            let longi = golden.longitude ?? ""
//            let goldenLat = (lati as NSString).doubleValue
//            let goldenLong = (longi as NSString).doubleValue
//            let destination = CLLocation(latitude: goldenLat, longitude: goldenLong)
//            let current = CLLocation(latitude: self.latitude ?? 0, longitude: self.longitude ?? 0)
//            let radiusDistance = current.distance(from: destination)
//            let distanceMeters = Measurement(value: radiusDistance, unit: UnitLength.meters)
//            let miles = distanceMeters.converted(to: UnitLength.miles).value.roundValue
//            print(miles)
//            if miles <= 3 {
//                let geofenceRegionCenter =  CLLocationCoordinate2DMake(goldenLat ,goldenLong)
//                let circularRegion = CLCircularRegion.init(center: geofenceRegionCenter,
//                                                           radius: golden.geoFencingRadius ?? 0.0,
//                                                           identifier: golden.name ?? "")
//                circularRegion.notifyOnEntry = true
//                circularRegion.notifyOnExit = false
//                locationManager.startMonitoring(for: circularRegion)
//
//            }
//            else {
//                let geofenceRegionCenter =  CLLocationCoordinate2DMake(goldenLat ,goldenLong)
//                let circularRegion = CLCircularRegion.init(center: geofenceRegionCenter,
//                                                           radius: golden.geoFencingRadius ?? 0.0,
//                                                           identifier: golden.name ?? "")
//                locationManager.stopMonitoring(for: circularRegion)
//            }
//        }
//
//        for recreation in SideMenuListVM.shared.recreationListing {
//            self.latitude = self.locationManager.location?.coordinate.latitude
//            self.longitude = self.locationManager.location?.coordinate.longitude
//            print(self.latitude ?? 0)
//            print(self.longitude ?? 0)
//
//            let lati = recreation.latitude ?? ""
//            let longi = recreation.longitude ?? ""
//            let recreationLat = (lati as NSString).doubleValue
//            let recreationLong = (longi as NSString).doubleValue
//            let destination = CLLocation(latitude: recreationLat, longitude: recreationLong)
//            let current = CLLocation(latitude: self.latitude ?? 0, longitude: self.longitude ?? 0)
//            let radiusDistance = current.distance(from: destination)
//            let distanceMeters = Measurement(value: radiusDistance, unit: UnitLength.meters)
//            let miles = distanceMeters.converted(to: UnitLength.miles).value.roundValue
//            print(miles)
//            if miles <= 3 {
//                let geofenceRegionCenter =  CLLocationCoordinate2DMake(recreationLat ,recreationLong)
//                let circularRegion = CLCircularRegion.init(center: geofenceRegionCenter,
//                                                           radius: recreation.geoFencingRadius ?? 0.0,
//                                                           identifier: recreation.name ?? "")
//                circularRegion.notifyOnEntry = true
//                circularRegion.notifyOnExit = false
//                locationManager.startMonitoring(for: circularRegion)
//
//            }
//            else {
//                let geofenceRegionCenter =  CLLocationCoordinate2DMake(recreationLat ,recreationLong)
//                let circularRegion = CLCircularRegion.init(center: geofenceRegionCenter,
//                                                           radius: recreation.geoFencingRadius ?? 0.0,
//                                                           identifier: recreation.name ?? "")
//                locationManager.stopMonitoring(for: circularRegion)
//            }
//        }
//
//
//        for calendar in SideMenuListVM.shared.calendarData {
//            self.latitude = self.locationManager.location?.coordinate.latitude
//            self.longitude = self.locationManager.location?.coordinate.longitude
//            print(self.latitude ?? 0)
//            print(self.longitude ?? 0)
//
//            let lati = calendar.latitude ?? ""
//            let longi = calendar.longitude ?? ""
//            let recreationLat = (lati as NSString).doubleValue
//            let recreationLong = (longi as NSString).doubleValue
//            let destination = CLLocation(latitude: recreationLat, longitude: recreationLong)
//            let current = CLLocation(latitude: self.latitude ?? 0, longitude: self.longitude ?? 0)
//            let radiusDistance = current.distance(from: destination)
//            let distanceMeters = Measurement(value: radiusDistance, unit: UnitLength.meters)
//            let miles = distanceMeters.converted(to: UnitLength.miles).value.roundValue
//            print(miles)
//            if miles <= 3 {
//                let geofenceRegionCenter =  CLLocationCoordinate2DMake(recreationLat ,recreationLong)
//                let circularRegion = CLCircularRegion.init(center: geofenceRegionCenter,
//                                                           radius: calendar.geoFencingRadius ?? 0.0,
//                                                           identifier: calendar.eventName ?? "")
//                circularRegion.notifyOnEntry = true
//                circularRegion.notifyOnExit = false
//                locationManager.startMonitoring(for: circularRegion)
//
//            }
//            else {
//                let geofenceRegionCenter =  CLLocationCoordinate2DMake(recreationLat ,recreationLong)
//                let circularRegion = CLCircularRegion.init(center: geofenceRegionCenter,
//                                                           radius: calendar.geoFencingRadius ?? 0.0,
//                                                           identifier:calendar.eventName ?? "")
//                locationManager.stopMonitoring(for: circularRegion)
//            }
//        }
//
//        print(locationManager.monitoredRegions)
//    }
//}
//
//extension BaseVC: MKMapViewDelegate {
//
//    func fireNotification(notificationText: String,title: String, didEnter: Bool) {
//        let notificationCenter = UNUserNotificationCenter.current()
//         notificationCenter.getNotificationSettings { (settings) in
//            if settings.alertSetting == .enabled {
//                let content = UNMutableNotificationContent()
//                content.title = didEnter ? title : title
//                content.body = notificationText
//                content.sound = UNNotificationSound.default
//                content.badge = 1
//                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
//
//                let request = UNNotificationRequest(identifier: self.EnteredRegionMessageNotificationId, content: content, trigger: trigger)
//
//                notificationCenter.add(request, withCompletionHandler: { (error) in
//                    if error != nil {
//                        // Handle the error
//                    }
//                })
//            }
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        //print("updating locations")
//        //we will right back
//        if enableMonitoring == true {
//            if counterState == true {
//                counter += 1
//                print(counter)
//       //         if counter == 10 {
//                    self.setUpGeofenceForAllScreens()
//                    counter = 0
//       //         }
//            }
//        }
//        else {
//             locationManager.stopUpdatingLocation()
//        }
//    }
//
//
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        //we will right back
//        if (status == CLAuthorizationStatus.authorizedAlways) {
//                counterState = true
//
//            }
//
//    }
//
//    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
//    //    showCustomAlert(title: region.identifier, message: "you are around \(region.identifier) Area.")
//        let date = Date()
//        let stringDate = date.stringFromDate(outputFormat: .dateTime, type: .utc)
//        print(region.identifier)
//
//        if region.identifier == "Beaver Deals" {
//            let notificationText = SideMenuListVM.shared.geoFencingData?.geofencingMessage ?? ""
//            fireNotification(notificationText: notificationText, title: region.identifier, didEnter: true)
//            if DataManager.notificationStatus == 1 {
//                CoreDataManager.saveLocalGeoNotificationData(title: notificationText, body: stringDate)
//            }
//        }
//
//        for business in SideMenuListVM.shared.businessListing {
//            if business.name == region.identifier && business.geofencingStatus == 1 {
//                let notificationText = "\(region.identifier) \(business.geofencingMessage ?? "")"
//                fireNotification(notificationText: notificationText, title: region.identifier, didEnter: true)
//                if DataManager.notificationStatus == 1 {
//                    CoreDataManager.saveLocalGeoNotificationData(title: notificationText, body: stringDate)
//                }
////                CoreDataManager.saveLocalGeoNotificationData(title: "Notification", body: "This is new Notification")
//            }
//        }
//
//        for discount in SideMenuListVM.shared.discountListing {
//            if discount.discount_business_name == region.identifier && discount.geofencingStatus == 1 {
//                let notificationText = "\(region.identifier) \(discount.geofencingMessage ?? "")"
//                fireNotification(notificationText: notificationText, title: region.identifier, didEnter: true)
//                if DataManager.notificationStatus == 1 {
//                    CoreDataManager.saveLocalGeoNotificationData(title: notificationText, body: stringDate)
//                }
//            }
//        }
//
//        for historical in SideMenuListVM.shared.historical {
//            if historical.name == region.identifier && historical.geofencingStatus == 1 {
//                let notificationText = "\(region.identifier) \(historical.geofencingMessage ?? "")"
//                fireNotification(notificationText: notificationText, title: region.identifier, didEnter: true)
//                if DataManager.notificationStatus == 1 {
//                    CoreDataManager.saveLocalGeoNotificationData(title: notificationText, body: stringDate)
//                }
//            }
//        }
//        for golden in SideMenuListVM.shared.goldenBeaverListing {
//            if golden.name == region.identifier && golden.geofencingStatus == 1 {
//                let notificationText = "\(region.identifier) \(golden.geofencingMessage ?? "")"
//                fireNotification(notificationText: notificationText, title: region.identifier, didEnter: true)
//                if DataManager.notificationStatus == 1 {
//                    CoreDataManager.saveLocalGeoNotificationData(title: notificationText, body: stringDate)
//                }
//            }
//        }
//        for recreation in SideMenuListVM.shared.recreationListing {
//            if recreation.name == region.identifier && recreation.geofencingStatus == 1 {
//                let notificationText = "\(region.identifier) \(recreation.geofencingMessage ?? "")"
//                fireNotification(notificationText: notificationText, title: region.identifier, didEnter: true)
//                if DataManager.notificationStatus == 1 {
//                    CoreDataManager.saveLocalGeoNotificationData(title: notificationText, body: stringDate)
//                }
//            }
//
//        }
//        for calendar in SideMenuListVM.shared.calendarData {
//            if calendar.eventName == region.identifier && calendar.geofencingStatus == 1{
//                let notificationText = "\(region.identifier) \(calendar.geofencingMessage ?? "")"
//                fireNotification(notificationText: notificationText, title: region.identifier, didEnter: true)
//                if DataManager.notificationStatus == 1 {
//                    CoreDataManager.saveLocalGeoNotificationData(title: notificationText, body: stringDate)
//                }
//            }
//        }
////        let notificationText = "You are around \(region.identifier) area."
////        let notificationText = "\(region.identifier) \(SideMenuListVM.shared.geoFencingMessage)"
////        fireNotification(notificationText: notificationText, title: region.identifier, didEnter: true)
////        self.createLocalNotification(message: EnteredRegionMessage, identifier: EnteredRegionMessageNotificationId,title: localGeoNotificationTitle)
//    }
//
//    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
//        print(region.identifier)
//    //    locationManager.stopMonitoring(for: region)
//        print("Stop Monitoring Region: \(region.identifier)")
////        showCustomAlert(title: region.identifier, message: "Thanks for the visit in \(region.identifier)")
////        let notificationText = "Thanks for the visit in \(region.identifier)"
////        fireNotification(notificationText: notificationText, title: region.identifier , didEnter: false)
//
//    }
//
//    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
//        print("Started Monitoring Region: \(region.identifier)")
//    }
//
//    //MARK: - MKMapViewDelegate
//      func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//          let overlayRenderer : MKCircleRenderer = MKCircleRenderer(overlay: overlay);
//          overlayRenderer.lineWidth = 4.0
//        overlayRenderer.strokeColor = UIColor(red: 0.0/255.0, green: 203.0/255.0, blue: 208.0/255.0, alpha: 1)
//        overlayRenderer.fillColor = UIColor(red: 7.0/255.0, green: 106.0/255.0, blue: 255.0/255.0, alpha: 1)
//        overlayRenderer.alpha = 0.5
//
//          return overlayRenderer
//      }
//}
//
//extension BaseVC {
//      func isLocationEnabled(lat: CLLocationDegrees, long: CLLocationDegrees, title: String) {
//              if CLLocationManager.locationServicesEnabled() {
//                 switch CLLocationManager.authorizationStatus() {
//                    case .notDetermined, .restricted, .denied:
//                 showCustomAlert(title: "Location", message: "Please enable location permissions in settings.", cancelButtonTitle: "No thanks", doneButtonTitle: "Open Settings", cancelCallback: {
//                            skipLocationPermission = true
//                        }) {
//                            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
//                        }
//
//                    case .authorizedAlways, .authorizedWhenInUse:
//                            LocationManager.shared.askPermissionsAndFetchLocationWithCompletion { (location, placeMark, error) in
//                           guard location != nil else {return}
//                           let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude:(location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)))
//                           source.name = "CurrentLocation"
//                           let latitude = Double(lat)
//                           let longitude = Double(long)
//    //                       let latitude = (self.locationLatitude! as NSString).doubleValue
//    //                       let longitude = (self.locationLongitude! as NSString).doubleValue
//                           let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: latitude , longitude: longitude)))
//                           destination.name = title
//                           MKMapItem.openMaps(with: [source, destination ], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
//                       }
//
//                 }
//              } else {
//               showCustomAlert(title: "Location", message: "Please enable location permissions in settings.", cancelButtonTitle: "No thanks", doneButtonTitle: "Open Settings", cancelCallback: {
//                   skipLocationPermission = true
//               }) {
//                   UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
//               }
//              }
//           }
//}
