//
//  NewsService.swift
//  NewsApp
//
//  Created by ios4 on 25/05/21.
//

import UIKit
import Foundation
import Alamofire

class NewsAPIService {
    var newsData = NewsDataModel(detail: JSONDictionary())
    var artDataArray = [Articles]()
    var artData = JSONDictionary()
    var srcDataArray = [Source]()
    var srcData = JSONDictionary()
    let defaults = UserDefaults.standard
    
    func getArticles(completion: @escaping (NewsDataModel) ->()) {
//        let selectedCountry = defaults.string(forKey: "selectedCountry") ?? ""
        let selectedCategory = self.defaults.string(forKey: "selectedCategory") ?? ""
        let url = "https://newsapi.org/v2/top-headlines?country=us&category=\(selectedCategory)&apiKey=4d3e1ce2523f46418ff4a356b80f556d"
        
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            
            if let error = response.error {
                print(error.localizedDescription)
            } else if response.data != nil {
                if let dict = response.value as? JSONDictionary
                {
                    print(dict)
                    let arts = dict["articles"] as? JSONArray ?? []
                    for art in arts {
                        var model = Articles(detail: art)
                        if let source = art["source"] as? JSONDictionary
                        {
                            let src = Source(detail: source)
                            self.srcDataArray.append(src)
                        }
                        model.source = self.srcDataArray
                        self.artDataArray.append(model)
                    }
                    self.newsData.articles = self.artDataArray
                    completion(self.newsData)
                }
            }
        }
    }
}
