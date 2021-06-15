//
//  Selection.swift
//  NewsApp
//
//  Created by ios4 on 11/06/21.
//

class Selection {
    static let instance = Selection()
    
    private init() {}
    
    // MARK: Global Variables
    var selectedCountry = ""
    var selectedCategory = ""
    var selectedCountryCode = ""
    var selectedCategoryCell = 0
    var selectedSourceName = ""
    var selectedSourceId = ""
}
