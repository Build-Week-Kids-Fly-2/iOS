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
    #warning("will need to probably change the name of the persistent container after he gives the other data.")
       let container = NSPersistentContainer(name: "User")
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
    
   func save(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
       context.performAndWait {
           do {
               try context.save()
           } catch {
               NSLog("Error saving context: \(error)")
               context.reset()
           }
       }
   }
}
