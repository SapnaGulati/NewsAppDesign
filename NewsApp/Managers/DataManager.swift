////
////  DataManager.swift
////  DT MedNet
////
////  Created by IOS3 on 01/10/19.
////  Copyright © 2019 Deftsoft. All rights reserved.
////

import Foundation

class DataManager {

    static var loginStatus: Bool? {
           set {
               UserDefaults.standard.setValue(newValue, forKey: APIKeys.kStatus)
               UserDefaults.standard.synchronize()
           }

           get {
            return UserDefaults.standard.bool(forKey: APIKeys.kStatus)
           }
       }

    static var accessToken: String? {
        set {
            UserDefaults.standard.setValue(newValue, forKey: APIKeys.kAccessToken)
            UserDefaults.standard.synchronize()
        }

        get {
            return UserDefaults.standard.string(forKey: APIKeys.kAccessToken)
        }
    }
    //
    //    static var savedTokens: Int? {
    //        set {
    //            UserDefaults.standard.setValue(newValue, forKey: APIKeys.kSavedToken)
    //            UserDefaults.standard.synchronize()
    //        }
    //
    //        get {
    //            return UserDefaults.standard.integer(forKey: APIKeys.kSavedToken)
    //        }
    //    }
    //
    //    static var individualPurchaseStatus: Int? {
    //        set {
    //            UserDefaults.standard.setValue(newValue, forKey: APIKeys.kIndividualPurchaseStatus)
    //            UserDefaults.standard.synchronize()
    //        }
    //
    //        get {
    //            return UserDefaults.standard.integer(forKey: APIKeys.kIndividualPurchaseStatus)
    //        }
    //    }
    //
    //    static var userType: String? {
    //           set {
    //               UserDefaults.standard.setValue(newValue, forKey: APIKeys.kUserType)
    //               UserDefaults.standard.synchronize()
    //           }
    //
    //           get {
    //               return UserDefaults.standard.string(forKey: APIKeys.kUserType)
    //           }
    //       }
    //
//    static var phoneNumber: String? {
//        set {
//            UserDefaults.standard.setValue(newValue, forKey: APIKeys.kPhone)
//            UserDefaults.standard.synchronize()
//        }
//
//        get {
//            return UserDefaults.standard.string(forKey: APIKeys.kPhone)
//        }
//    }
//
//    static var id: Int? {
//        set {
//            UserDefaults.standard.setValue(newValue, forKey: APIKeys.kID)
//            UserDefaults.standard.synchronize()
//        }
//        get {
//            return UserDefaults.standard.integer(forKey: APIKeys.kID)
//        }
//    }
//
//    static var verifyOTP: Int? {
//        set {
//            UserDefaults.standard.setValue(newValue, forKey: APIKeys.kVerifyOtp)
//            UserDefaults.standard.synchronize()
//        }
//
//        get {
//            return UserDefaults.standard.integer(forKey: APIKeys.kVerifyOtp)
//        }
//    }
//
//    static var nationality: String? {
//        set {
//            UserDefaults.standard.setValue(newValue, forKey: APIKeys.kNationality)
//            UserDefaults.standard.synchronize()
//        }
//
//        get {
//            return UserDefaults.standard.string(forKey: APIKeys.kNationality)
//        }
//    }
//
//    static var countryOfResident: String? {
//        set {
//            UserDefaults.standard.setValue(newValue, forKey: APIKeys.kResidence)
//            UserDefaults.standard.synchronize()
//        }
//
//        get {
//            return UserDefaults.standard.string(forKey: APIKeys.kResidence)
//        }
//    }
//
//    static var userEmail: String? {
//        set {
//            UserDefaults.standard.setValue(newValue, forKey: APIKeys.kEmail)
//            UserDefaults.standard.synchronize()
//        }
//
//        get {
//            return UserDefaults.standard.string(forKey: APIKeys.kEmail)
//        }
//    }
//
//    static var firstname: String? {
//        set {
//            UserDefaults.standard.setValue(newValue, forKey: APIKeys.kFirstName)
//            UserDefaults.standard.synchronize()
//        }
//
//        get {
//            return UserDefaults.standard.string(forKey: APIKeys.kFirstName)
//        }
//    }
//
//    static var lastname: String? {
//        set {
//            UserDefaults.standard.setValue(newValue, forKey: APIKeys.kLastName)
//            UserDefaults.standard.synchronize()
//        }
//
//        get {
//            return UserDefaults.standard.string(forKey: APIKeys.kLastName)
//        }
//    }
//
//    static var dob: String? {
//        set {
//            UserDefaults.standard.setValue(newValue, forKey: APIKeys.kDOB)
//            UserDefaults.standard.synchronize()
//        }
//
//        get {
//            return UserDefaults.standard.string(forKey: APIKeys.kDOB)
//        }
//    }

}

