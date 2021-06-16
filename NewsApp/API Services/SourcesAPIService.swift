//
//  SourcesAPIService.swift
//  NewsApp
//
//  Created by ios4 on 14/06/21.
//

import Foundation

enum SourcesAPIService: APIService {
    
    case getSources

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
        let header  = [APIKeys.kAuthorizationToken:"Bearer \(APIKeys.kAccessToken)","Accept":"application/json"]
        switch self {
        case .getSources:
            resource = Resource(method: .get, parameters: nil, headers: header)
        }
        return resource
    }
}

extension APIManager{
    
    class func callApiToGetSources(successCallback:@escaping JSONDictionaryResponseCallback,failureCallBack:@escaping APIServiceFailureCallback){
        SourcesAPIService.getSources.request(success: { (response) in
            if let responseDict = response as? JSONDictionary {
                successCallback(responseDict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallBack)
    }
}
