//
//  CountryDataModel.swift
//  NewsApp
//
//  Created by ios4 on 14/06/21.
//

import Foundation

struct CountryDataModel {
    var id: String?
    var name: String?
    
    init(detail: JSONDictionary) {
        self.id = detail["id"] as? String
        self.name = detail["name"] as? String
    }
}
