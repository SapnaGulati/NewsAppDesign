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
        self.status = detail[APIKeys.kStatus] as? String
        
        for source in detail[APIKeys.kSources] as? JSONArray ?? []
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
        self.id = dict[APIKeys.kId] as? String
        self.name = dict[APIKeys.kName] as? String
        self.description = dict[APIKeys.kDescription] as? String
        self.url = dict[APIKeys.kURL] as? String
        self.category = dict[APIKeys.kCategory] as? String
        self.language = dict[APIKeys.kLanguage] as? String
        self.country = dict[APIKeys.kCountry] as? String
    }
}
