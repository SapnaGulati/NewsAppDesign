//
//  CountryCode.swift
//
//  NewsApp
//
//  Created by ios4 on 13/05/21.

import Foundation

class CountryCode {
    
    static var shared = CountryCode()
    private init() {}
    
    func getFlag(country:String) -> String{
        var flag = String()
        if let path = Bundle.main.path(forResource: "flag-emojis.pretty", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonArray = jsonResult as? [JSONDictionary] {
                    for i in jsonArray {
                        if let coun = i["name"] as? String{
                            if coun.lowercased() == country.lowercased(){
                                flag = i["emoji"] as? String ?? ""
                            }
                        }
                    }
                }
            } catch {
                print("Flag not found")
            }
        }
        return flag
    }
    
    func getCode(country:String) -> String{
        var code = String()
        if let path = Bundle.main.path(forResource: "flag-emojis.pretty", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonArray = jsonResult as? [JSONDictionary] {
                    for i in jsonArray {
                        if let coun = i["name"] as? String{
                            if coun.lowercased() == country.lowercased(){
                                code = i["code"] as? String ?? ""
                            }
                        }
                    }
                }
            } catch {
                print("Code not found")
            }
        }
        return code
    }
}
