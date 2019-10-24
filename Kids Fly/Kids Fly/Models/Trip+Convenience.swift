//
//  Trip+Convenience.swift
//  Kids Fly
//
//  Created by Marc Jacques on 10/22/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import Foundation
import CoreData

extension Trip {
    
    @discardableResult convenience init(airport: String, airline: String, flightNumber: String, departureTime: String, carryOnBags: Int32, checkedBags: Int32, children: Int32, arrived: Bool, enRoute: Bool, identifier: Int32?, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        
        self.airport       = airport
        self.airline       = airline
        self.flightNumber  = flightNumber
        self.departureTime = departureTime
        self.carryOnBags   = carryOnBags
        self.checkedBags   = checkedBags
        self.children      = children
        self.arrived       = arrived
        self.enRoute       = enRoute
        self.identifier    = identifier ?? 0
    }
    
    @discardableResult convenience init?(tripRepresentation: TripRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        guard let airport = tripRepresentation.airport,
            let airline = tripRepresentation.airline,
            let flightNumber = tripRepresentation.flightNumber,
            let departureTime = tripRepresentation.departureTime,
            let carryOnBags = tripRepresentation.carryOnBags,
            let checkedBags = tripRepresentation.checkedBags,
            let children = tripRepresentation.children,
            let arrived = tripRepresentation.arrived,
            let enRoute = tripRepresentation.enRoute,
            let identifier = tripRepresentation.identifier else { return nil }
        
        self.init(airport: airport, airline: airline, flightNumber: flightNumber, departureTime: departureTime, carryOnBags: carryOnBags, checkedBags: checkedBags, children: children, arrived: arrived, enRoute: enRoute, identifier: identifier)
    }
    
    var tripRepresentation: TripRepresentation {
        return TripRepresentation(airport: airport, airline: airline, flightNumber: flightNumber, departureTime: departureTime, carryOnBags: carryOnBags, checkedBags: checkedBags, children: children, arrived: arrived, enRoute: enRoute, identifier: identifier)
    }
    
}
