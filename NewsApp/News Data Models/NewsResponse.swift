//
//  NewsResponse.swift
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
    var source: [Source] = []
    var author: String?
    var title: String?
    var description: String?
    var publishedAt: String?
    var urlToImage: String?
    var url: String?
    
    init(detail: JSONDictionary) {
        for src in detail["source"] as? JSONArray ?? []
        {
            let post = Source(detail: src)
            self.source.append(post)
        }
        self.author = detail["author"] as? String
        self.title = detail["title"] as? String
        self.description = detail["description"] as? String
        self.publishedAt = detail["publishedAt"] as? String
        self.urlToImage = detail["urlToImage"] as? String
        self.url = detail["url"] as? String
    }
}

struct Source {
    var id: String?
    var name: String?
    
    init(detail: JSONDictionary) {
        self.id = detail["id"] as? String
        self.name = detail["name"] as? String
    }
}
