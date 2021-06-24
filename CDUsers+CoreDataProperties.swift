//
//  CDUsers+CoreDataProperties.swift
//  NewsApp
//
//  Created by ios4 on 24/06/21.
//
//

import Foundation
import CoreData


extension CDUsers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUsers> {
        return NSFetchRequest<CDUsers>(entityName: "CDUsers")
    }

    @NSManaged public var selectedCategory: String?
    @NSManaged public var selectedCountry: String?
    @NSManaged public var userId: String?
    @NSManaged public var selectedCategoryIndex: Int16
    
    func convertToUser() -> User
    {
        return User(selectedCountry: self.selectedCountry, selectedCategory: self.selectedCategory, selectedCategoryIndex: self.selectedCategoryIndex, userId: self.userId!)
    }
}
