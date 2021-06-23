//
//  UserRepository.swift
//  NewsApp
//
//  Created by ios4 on 23/06/21.
//

import Foundation
import CoreData

protocol UserRepo {

    func create(user: Users)
    func getAll() -> [Users]?
    func get(byIdentifier id: UUID) -> Users?
    func update(user: Users)
    func delete(id: UUID)
}

struct UserRepository : UserRepo
{
    func create(user: Users) {
        let cdUser = Users(context: PersistentStorage.shared.context)
        cdUser.userId = user.userId
        cdUser.selectedCategory = user.selectedCategory
        cdUser.selectedCountry = user.selectedCountry
        PersistentStorage.shared.saveContext()
    }

    func getAll() -> [Users]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: Users.self)
        return result
    }

    func get(byIdentifier id: UUID) -> Users? {
        let fetchRequest = NSFetchRequest<Users>(entityName: "CDEmployee")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else {return nil}
            return result
        } catch let error {
            debugPrint(error)
        }
        return nil
    }

    func update(user: Users) {
        // update code here
    }

    func delete(id: UUID) {
        // delete code here
    }
}
