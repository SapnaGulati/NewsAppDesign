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
    var selectedSourceName = ""
    var selectedSourceId = ""
    var selectedFlag = CountryCode.shared.getFlag(country: DataManager.selectedCountry ?? "")
    var searchParams = ""
    var selectedCountry = DataManager.selectedCountry
    var selectedCategory = DataManager.selectedCategory
    var selectedCategoryIndex = DataManager.selectedCategoryIndex
}
