//
//  NewsAPIService.swift
//  NewsApp
//
//  Created by ios4 on 14/06/21.
//

import Foundation

enum NewsAPIService: APIService {
    
    case callApiToGetArticlesByCounAndCat(selectedCountry: String, selectedCategory: String)
    case callApiToGetArticlesBySource(selectedSource: String)
    case callApiToGetArticlesBySearch(searchParams: String)
    
    var path: String{
        var path = ""
        switch self {
            case let .callApiToGetArticlesByCounAndCat(selectedCountry, selectedCategory):
                if(selectedCategory == "All") {
                    path = BASEURL.appending("top-headlines?country=\(selectedCountry)")
                }
                else {
                    path = BASEURL.appending("top-headlines?country=\(selectedCountry)&category=\(selectedCategory)")
                }
            
            case let .callApiToGetArticlesBySource(selectedSource):
                path = BASEURL.appending("top-headlines?sources=\(selectedSource)")
                
            case let .callApiToGetArticlesBySearch(searchParams):
                path = BASEURL.appending("top-headlines?q=\(searchParams)")
        }
        return path
    }
    
    var resource: Resource{
        var resource : Resource!
        let header  = [APIKeys.kAuthorizationToken:"Bearer \(APIKeys.kAccessToken)","Accept":"application/json"]
        switch self {
            case .callApiToGetArticlesByCounAndCat:
                resource = Resource(method: .get, parameters: nil, headers: header)
            
            case .callApiToGetArticlesBySource:
                resource = Resource(method: .get, parameters: nil, headers: header)
                
            case .callApiToGetArticlesBySearch:
                resource = Resource(method: .get, parameters: nil, headers: header)
        }
        return resource
    }
}

extension APIManager{
    
    class func callApiToGetArticlesByCounAndCat(selectedCountry: String, selectedCategory: String, successCallback:@escaping JSONDictionaryResponseCallback, failureCallBack:@escaping APIServiceFailureCallback){
        NewsAPIService.callApiToGetArticlesByCounAndCat(selectedCountry: selectedCountry, selectedCategory: selectedCategory).request( success: { (response) in
            if let responseDict = response as? JSONDictionary {
                successCallback(responseDict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallBack)
    }
    
    class func callApiToGetArticlesBySource(selectedSource: String, successCallback:@escaping JSONDictionaryResponseCallback, failureCallBack:@escaping APIServiceFailureCallback){
        NewsAPIService.callApiToGetArticlesBySource(selectedSource: selectedSource).request( success: { (response) in
            if let responseDict = response as? JSONDictionary {
                successCallback(responseDict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallBack)
    }
    
    class func callApiToGetArticlesBySearch(searchParams: String, successCallback:@escaping JSONArrayResponseCallback, failureCallBack:@escaping APIServiceFailureCallback){
        NewsAPIService.callApiToGetArticlesBySearch(searchParams: searchParams).request( success: { (response) in
            if let responseDict = response as? JSONDictionary {
                successCallback(responseDict)
            }else{
                successCallback([:])
            }
        }, failure: failureCallBack)
    }
}
