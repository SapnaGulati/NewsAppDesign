//
//  NewsDM.swift
//  NewsApp
//
//  Created by ios4 on 25/05/21.
//

import UIKit
import Foundation

struct NewsDM {
    var status: String?
    var totalResults: Int?
    var articles: [Articles] = []
    
    init(detail:JSONDictionary) {
        self.status = detail[APIKeys.kStatus] as? String
        self.totalResults = detail[APIKeys.kTotalResults] as? Int
        for article in detail[APIKeys.kArticles] as? JSONArray ?? []
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
        self.author = detail[APIKeys.kAuthor] as? String
        self.title = detail[APIKeys.kTitle] as? String
        self.description = detail[APIKeys.kDescription] as? String
        self.publishedAt = detail[APIKeys.kPublishedAt] as? String
        self.urlToImage = detail[APIKeys.kURLToImage] as? String
        self.url = detail[APIKeys.kURL] as? String
        if let source =  detail[APIKeys.kSource] as? JSONDictionary{
            self.sourceName = source[APIKeys.kSourceName] as? String
        }
    }
}
