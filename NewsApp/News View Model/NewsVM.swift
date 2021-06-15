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
    
    func getArticles(selectedCategory: String, selectedCountry: String, completion: @escaping (NewsDM) ->()) {
        let url: String!
        if (selectedCategory == "All") {
            url = "https://newsapi.org/v2/top-headlines?country=\(selectedCountry)&apiKey=4d3e1ce2523f46418ff4a356b80f556d"
        }
        else {
            url = "https://newsapi.org/v2/top-headlines?country=\(selectedCountry)&category=\(selectedCategory)&apiKey=4d3e1ce2523f46418ff4a356b80f556d"
        }
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            if let error = response.error {
                print(error.localizedDescription)
            } else if response.data != nil {
                if let dict = response.value as? JSONDictionary
                {
                    print(dict)
                    self.artDataArray.removeAll()
                    let arts = dict["articles"] as? JSONArray ?? []
                    for art in arts {
                        let model = Articles(detail: art)
                        self.artDataArray.append(model)
                    }
                    self.newsData.articles = self.artDataArray
                    completion(self.newsData)
                }
            }
        }
    }
    
    func getArticles(selectedSource: String, completion: @escaping (NewsDM) ->()) {
        let url = "https://newsapi.org/v2/top-headlines?sources=\(selectedSource)&apiKey=4d3e1ce2523f46418ff4a356b80f556d"
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            if let error = response.error {
                print(error.localizedDescription)
            } else if response.data != nil {
                if let dict = response.value as? JSONDictionary
                {
                    print(dict)
                    self.artDataArray.removeAll()
                    let arts = dict["articles"] as? JSONArray ?? []
                    for art in arts {
                        let model = Articles(detail: art)
                        self.artDataArray.append(model)
                    }
                    self.newsData.articles = self.artDataArray
                    completion(self.newsData)
                }
            }
        }
    }
}
