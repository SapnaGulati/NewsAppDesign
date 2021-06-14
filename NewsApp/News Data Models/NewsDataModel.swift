//
//  NewsDM.swift
//  NewsApp
//
//  Created by ios4 on 25/05/21.
//

import UIKit
import Foundation

typealias JSONDictionary = [String:Any]
typealias JSONArray = [JSONDictionary]

struct NewsDataModel {
    var status: String?
    var totalResults: Int?
    var articles: [Articles] = []
    
    init(detail:JSONDictionary) {
        self.status = detail["status"] as? String
        self.totalResults = detail["totalresults"] as? Int
        
        for article in detail["articles"] as? JSONArray ?? []
        {
            let post = Articles(detail: article)
            self.articles.append(post)
        }
    }
}

struct Articles {
    var author: String?
    var title: String?
    var description: String?
    var publishedAt: String?
    var urlToImage: String?
    var url: String?
    var sourceName: String?
    
    init(detail: JSONDictionary) {
        self.author = detail["author"] as? String
        self.title = detail["title"] as? String
        self.description = detail["description"] as? String
        self.publishedAt = detail["publishedAt"] as? String
        self.urlToImage = detail["urlToImage"] as? String
        self.url = detail["url"] as? String
        if let source =  detail["source"] as? JSONDictionary{
            self.sourceName = source["name"] as? String
        }
    }
}
