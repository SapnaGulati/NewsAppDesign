//
//  CountryList.swift
//  NewsApp
//
//  Created by ios4 on 13/05/21.
//

import UIKit

class CountryList {
 static func getCountries() -> [country]{
   let countries = [
    country(name: "India", c_code: "in"),
    country(name: "U.S.A", c_code: "us"),
    country(name: "Canada", c_code: "ca"),
    country(name: "United Kingdom", c_code: "gb"),
    country(name: "France", c_code: "fr"),
    country(name: "Russia", c_code: "ru"),
    country(name: "Australia", c_code: "au"),
    country(name: "Belgium", c_code: "bg"),
    country(name: "China", c_code: "cn")
    ]
   return countries
  }
}
