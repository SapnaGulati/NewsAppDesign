//
//  CountryCode.swift
//  NewsApp
//
//  Created by ios4 on 15/06/21.
//

import Foundation

class CountryCode {
    
    static var shared = CountryCode()
    private init() {}
    
    func getPhoneCodeArray() -> [String] {
        var codeArray = [String]()
        if let path = Bundle.main.path(forResource: "CountryCodes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonArray = jsonResult as? [JSONDictionary] {
                    for i in jsonArray {
                        if var countryCode = i["num_code"] as? String {
                            countryCode = "+" + countryCode.replacingOccurrences(of: " ", with: "")
                            if countryCode.count > 0 {
                                codeArray.append(countryCode)
                            }
                        }
                    }
                    //Remove duplicate value
                    codeArray = Array(Set(codeArray))
                    codeArray = codeArray.sorted()
                }
            } catch {
                // handle error
            }
        }
        return codeArray
    }
    
    func getNationality() -> [String]{
        var codeArray = [String]()
        if let path = Bundle.main.path(forResource: "CountryCodes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonArray = jsonResult as? [JSONDictionary] {
                    for i in jsonArray {
                        if let countryCode = i["nationality"] as? String {
                           // countryCode = countryCode.replacingOccurrences(of: " ", with: "")
                            if countryCode.count > 0 {
                                codeArray.append(countryCode)
                            }
                        }
                    }
                    //Remove duplicate value
                    codeArray = Array(Set(codeArray))
                    codeArray = codeArray.sorted()
                }
            } catch {
                // handle error
            }
        }
        return codeArray
    }

    func getCountry() -> [String]{
        var codeArray = [String]()
        if let path = Bundle.main.path(forResource: "CountryCodes", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonArray = jsonResult as? [JSONDictionary] {
                    for i in jsonArray {
                        if let countryCode = i["en_short_name"] as? String {
                           // countryCode = countryCode.replacingOccurrences(of: " ", with: "")
                            if countryCode.count > 0 {
                                codeArray.append(countryCode)
                            }
                        }
                    }
                    //Remove duplicate value
                    codeArray = Array(Set(codeArray))
                    codeArray = codeArray.sorted()
                }
            } catch {
                // handle error
            }
        }
        return codeArray
    }
    
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
                // handle error
            }
        }
        return flag
    }
    
}

