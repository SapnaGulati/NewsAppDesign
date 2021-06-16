//
//  NewsService.swift
//  NewsApp
//
//  Created by ios4 on 25/05/21.
//

import UIKit
import Foundation
import Alamofire

class NewsVM {
    
    static var shared = NewsVM()
    
    var newsData = NewsDM(detail: JSONDictionary())
    var artDataArray = [Articles]()
    var artData = Articles(detail: JSONDictionary())
    
    private init() {}
    
    func callApiToGetArticlesByCounAndCat(selectedCountry: String, selectedCategory: String, response:@escaping responseCallBack){
        APIManager.callApiToGetArticlesByCounAndCat(selectedCountry: selectedCountry, selectedCategory: selectedCategory, successCallback: { (responseDict) in
        let message = responseDict[APIKeys.kMessage] as? String ?? kSomethingWentWrong
        if self.parseGetArticles(response: responseDict){
            response(message, nil)
        } else {
            response(nil, nil)
        }
    }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
    
    func callApiToGetArticlesBySource(selectedSource: String, response:@escaping responseCallBack){
        APIManager.callApiToGetArticlesBySource(selectedSource: selectedSource, successCallback: { (responseDict) in
        let message = responseDict[APIKeys.kMessage] as? String ?? kSomethingWentWrong
        if self.parseGetArticles(response: responseDict){
            response(message, nil)
        } else {
            response(nil, nil)
        }
    }) { (errorReason, error) in
            response(nil, APIManager.errorForNetworkErrorReason(errorReason: errorReason!))
        }
    }
}

extension NewsVM{
    func parseGetArticles(response: JSONDictionary) -> Bool{
        artDataArray.removeAll()
        if let data = response[APIKeys.kArticles] as? JSONArray {
            for art in data {
                let model = Articles(detail: art)
                self.artDataArray.append(model)
            }
            self.newsData.articles = self.artDataArray
        }
        return true
    }
}
