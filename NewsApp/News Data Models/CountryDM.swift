//
//  CountryDM.swift
//  NewsApp
//
//  Created by ios4 on 14/06/21.
//

import Foundation

struct CountryDM {
    var id: Int?
    var code: String?
    var name: String?
    var flag: String?
        
    init(dict: JSONDictionary) {
        id = dict[APIKeys.kId] as? Int
        code = dict[APIKeys.kCode] as? String
        name = dict[APIKeys.kName] as? String
        flag = dict[APIKeys.kFlag] as? String
        }
}
