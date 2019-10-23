//
//  CoreDataStack.swift
//  Kids Fly
//
//  Created by Marc Jacques on 10/21/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
   static let shared = CoreDataStack()
   private init() {
   }
    
   lazy var container: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Trips")
       container.loadPersistentStores(completionHandler: { (_, error) in
           if let error = error {
               fatalError("Failed to load persistent stores: \(error)")
           }
       })
       container.viewContext.automaticallyMergesChangesFromParent = true
       return container
   }()
    
   var mainContext: NSManagedObjectContext {
       return container.viewContext
   }
    
   func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) throws {
    var error: Error?
    
       context.performAndWait {
           do {
               try context.save()
           } catch {
               NSLog("Error saving context: \(error)")
               context.reset()
           }
       }
    
    if let error = error {
        throw error
    }
   }
}
