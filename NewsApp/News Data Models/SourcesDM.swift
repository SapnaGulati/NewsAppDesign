//
//  SourcesDM.swift
//  NewsApp
//
//  Created by ios4 on 14/06/21.
//

import Foundation

struct SourcesDM {
    var status: String?
    var sources: [Sources] = []
    
    init(detail:JSONDictionary) {
        self.status = detail["status"] as? String
        
        for source in detail["sources"] as? JSONArray ?? []
        {
            let post = Sources(dict: source)
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
    
    init(dict: JSONDictionary) {
        self.id = dict["id"] as? String
        self.name = dict["name"] as? String
        self.description = dict["description"] as? String
        self.url = dict["url"] as? String
        self.category = dict["category"] as? String
        self.language = dict["language"] as? String
        self.country = dict["country"] as? String
    }
}
