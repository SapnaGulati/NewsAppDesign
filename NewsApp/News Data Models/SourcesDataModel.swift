//
//  SourcesDataModel.swift
//  NewsApp
//
//  Created by ios4 on 14/06/21.
//

import Foundation

struct SourcesDataModel {
    var status: String?
    var sources: [Sources] = []
    
    init(detail:JSONDictionary) {
        self.status = detail["status"] as? String
        
        for source in detail["sources"] as? JSONArray ?? []
        {
            let post = Sources(detail: source)
            self.sources.append(post)
        }
    }
}

struct Sources {
    var id: String?
    var name: String?
    var description: String?
    var url: String?
    var category: String?
    var language: String?
    var country: String?
    
    init(detail: JSONDictionary) {
        self.id = detail["id"] as? String
        self.name = detail["name"] as? String
        self.description = detail["description"] as? String
        self.url = detail["url"] as? String
        self.category = detail["category"] as? String
        self.language = detail["language"] as? String
        self.country = detail["country"] as? String
    }
}
