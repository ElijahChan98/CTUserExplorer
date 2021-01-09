//
//  CTUserPersistence.swift
//  CTUserExplorer
//
//  Created by Elijah Tristan Huey Chan on 1/9/21.
//  Copyright © 2021 Elijah Tristan Huey Chan. All rights reserved.
//

import UIKit
import CoreData

class CTUserPersistence {
    public static let shared = CTUserPersistence()
    
    func saveContext(forContext context: NSManagedObjectContext) {
        if context.hasChanges {
            context.performAndWait {
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

    func save(ctUser: CTUser) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "CTUserEntity", in: managedContext)!
        let avatar = NSManagedObject(entity: entity, insertInto: managedContext)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CTUserEntity")
        let predicate = NSPredicate(format: "username = %@", ctUser.username!)
        fetchRequest.predicate = predicate
        
        managedContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        let backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.parent = managedContext
        
        backgroundContext.performAndWait {
            do {
                let object = try managedContext.fetch(fetchRequest)
                if object.count == 0 || object.count == 1 {
                    avatar.setValue(ctUser.username, forKey: "username")
                    avatar.setValue(ctUser.password, forKey: "password")
                    avatar.setValue(ctUser.countryOfOrigin, forKey: "countryOfOrigin")

                    saveContext(forContext: backgroundContext)
                }
                else {
                    
                    return
                }
            }
            catch {
                print(error.localizedDescription)
            }
            saveContext(forContext: managedContext)
        }
    }
    
    func retrieve(username: String, completion: @escaping (_ success: Bool, _ ctUser: CTUser?) -> ()) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CTUserEntity")
        let predicate = NSPredicate(format: "username = %@", username)
        fetchRequest.predicate = predicate
        do {
            let object = try managedContext.fetch(fetchRequest)
            if object.count == 1 {
                let firstObject = object.first!
                let ctUser = CTUser()
                ctUser.username = firstObject.value(forKeyPath: "username") as? String
                ctUser.password = firstObject.value(forKeyPath: "password") as? String
                ctUser.countryOfOrigin = firstObject.value(forKeyPath: "countryOfOrigin") as? String
                
                completion(true, ctUser)
            }
            else {
                completion(false, nil)
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completion(false, nil)
        }
    }
    
    func validate(username: String, password: String, completion: @escaping (_ success: Bool) -> ()) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CTUserEntity")
        let usernamePredicate = NSPredicate(format: "username = %@", username)
        let passwordPredicate = NSPredicate(format: "password = %@", password)
        let andPredicate = NSCompoundPredicate(type: .and, subpredicates: [usernamePredicate, passwordPredicate])
        fetchRequest.predicate = andPredicate
        do {
            let object = try managedContext.fetch(fetchRequest)
            if object.count == 1 {
                completion(true)
            }
            else {
                completion(false)
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completion(false)
        }
    }
}
