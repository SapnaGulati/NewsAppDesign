//
//  CountryDM.swift
//  NewsApp
//
//  Created by ios4 on 14/06/21.
//

import Foundation

struct CountryDM {
    var id: Int?
    var name: String?
    var flag: String?
        
    init(dict: JSONDictionary) {
        id = dict["id"] as? Int
        name = dict["name"] as? String
        flag = dict["flag"] as? String
        }
}
