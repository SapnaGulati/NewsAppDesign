//
//  Users+CoreDataProperties.swift
//  NewsApp
//
//  Created by ios4 on 23/06/21.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var selectedCategory: String?
    @NSManaged public var selectedCountry: String?
    @NSManaged public var userId: UUID?
}
