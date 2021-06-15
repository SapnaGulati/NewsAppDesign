//
//  CountryAPIService.swift
//  NewsApp
//
//  Created by ios4 on 14/06/21.
//

import Foundation

enum CountryAPIService: APIService{

case country

    var path: String{
        var path = ""
        switch self {

        case .country:
            path = "http://1.6.98.142/wasafiri/api/v1/get-country-list"

        }
        return path
    }

    var resource: Resource{
        var resource : Resource!
        let header  = ["Authorization":"Bearer \(DataManager.accessToken ?? "")","Accept":"application/json"]

        switch self {
        case .country:
            resource = Resource(method: .get, parameters: nil, headers: header)
        }
         return resource
    }
}

extension APIManager {

    class func callApiForCountry( successCallback: @escaping JSONDictionaryResponseCallback, failureCallback: @escaping APIServiceFailureCallback){
        CountryAPIService.country.request( success: { (response) in
            if let responseDict = response as? JSONDictionary {
                successCallback(responseDict)

            }else {
                successCallback([:])
            }
        }, failure: failureCallback)
    }
}
