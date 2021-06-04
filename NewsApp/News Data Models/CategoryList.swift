//
//  CategoryList.swift
//  NewsApp
//
//  Created by ios4 on 17/05/21.
//

import UIKit

class CategoryList {
 static func getCategories() -> [Category]{
   let categories = [
    Category(name: "All"),
    Category(name: "Business"),
    Category(name: "Entertainment"),
    Category(name: "General"),
    Category(name: "Health"),
    Category(name: "Science"),
    Category(name: "Sports"),
    Category(name: "Technology")
    ]
   return categories
  }
}
