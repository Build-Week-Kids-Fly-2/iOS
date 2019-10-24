//
//  User+Convenience.swift
//  Kids Fly
//
//  Created by Jake Connerly on 10/23/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import Foundation
import CoreData

extension User {
    @discardableResult convenience init(email: String, password: String, fullName: String, context: NSManagedObjectContext = CoreDataStack.shared.mainContext){
        self.init(context: context)
        
        self.email = email
        self.password = password
        self.fullName = fullName
    }
    
    @discardableResult convenience init?(userRepresentation: UserRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        
        self.email = userRepresentation.email
        self.password = userRepresentation.password
        self.fullName = userRepresentation.fullName
    }
    
    var userRepresentation: UserRepresentation {
        return UserRepresentation(email: email, password: password, fullName: fullName)
    }
}
