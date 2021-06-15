//
//  SourcesAPIService.swift
//  NewsApp
//
//  Created by ios4 on 14/06/21.
//

import Foundation

enum SourcesAPIService: APIService {
    
    case getSources(dict:JSONDictionary)

    var path: String{
        var path = ""
        switch self {
        case .getSources:
            path = BASEURL.appending("sources")
        }
        return path
    }

    var resource: Resource{
        var resource : Resource!
        let header  = [APIKeys.kAuthorizationToken:"Bearer \(DataManager.accessToken ?? "")","Accept":"application/json"]
        switch self {
        case let .getSources(dict):
            resource = Resource(method: .post, parameters: dict, headers: nil)
        }
        return resource
    }
}

//extension APIManager{
//    class func callApiForSources( successCallback: @escaping JSONDictionaryResponseCallback, failureCallback: @escaping APIServiceFailureCallback){
//        SourcesAPIService.getSources.request( success: { (response) in
//            if let responseDict = response as? JSONDictionary {
//                successCallback(responseDict)
//
//            }else {
//                successCallback([:])
//            }
//        }, failure: failureCallback)
//}
