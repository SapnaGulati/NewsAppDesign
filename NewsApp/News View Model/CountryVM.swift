//
//  CountryVM.swift
//  NewsApp
//
//  Created by ios4 on 14/06/21.
//

import Foundation

class CountryVM {

    static var shared = CountryVM()
    var country = [CountryDM]()
    var selectedCountry = [CountryDM]()
    
    private init() {}
    
    func callApiForCountry( response: @escaping responseCallBack){
           APIManager.callApiForCountry( successCallback: { (responseDict) in
               let message = responseDict[APIKeys.kMessage] as? String ?? "Something Wrong"
            if let data = responseDict[APIKeys.kData] as? JSONArray {
               
                self.parsingCountryData(response: data)
               }
               response(message, nil)
           }) { (errorReason, error) in
               response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
           }
       }
}
