//
//  UserRepository.swift
//  NewsApp
//
//  Created by ios4 on 23/06/21.
//

import Foundation
import CoreData

protocol UserRepo {

    func create(user: User)
    func getAll() -> [User]?
    func get(byIdentifier userId: String) -> User?
    func update(user: User)
    func delete(userId: String)
}

struct UserRepository : UserRepo
{
    func create(user: User) {
        let cdUser = CDUsers(context: PersistentStorage.shared.context)
        cdUser.userId = user.userId
        cdUser.selectedCategory = user.selectedCategory
        cdUser.selectedCountry = user.selectedCountry
        cdUser.selectedCategoryIndex = user.selectedCategoryIndex ?? 0
        PersistentStorage.shared.saveContext()
    }

    func getAll() -> [User]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDUsers.self)
        
        var users : [User] = []
        result?.forEach({ (cdUser) in
            users.append(cdUser.convertToUser())
        })
        return users
    }

    func get(byIdentifier userId: String) -> User? {
        let fetchRequest = NSFetchRequest<CDUsers>(entityName: "CDUsers")
        let predicate = NSPredicate(format: "userId==%@", userId as CVarArg)
        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else {return nil}
            return result?.convertToUser()
        } catch let error {
            debugPrint(error)
        }
        return nil
    }

    func update(user: User) {
    }

    func delete(userId: String) {
    }
}
