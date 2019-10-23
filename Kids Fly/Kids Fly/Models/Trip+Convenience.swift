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
    var tripRepresentation: TripRepresentation? {
        guard let airport = airport,
            let airline = airline,
            let flightNumber = flightNumber,
            let departureTime = departureTime,
            let carryOnBags = carryOnBags,
            let checkedBags = checkedBags,
            let children =  children,
            let arrived = arrived,
            let enRoute = enRoute else { return nil }
        return TripRepresentation(airport: airport, airline: airline, flightNumber: flightNumber, departureTime: departureTime, carryOnBags: carryOnBags, checkedBags: checkedBags, children: children, arrived: arrived, enRoute: enRoute)
    }
    
    convenience init(airport: String,
                     airline: String, flightNumber: String, departureTime: String, carryOnBags: String, checkedBags: String, children: String, arrived: String, enRoute: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.airport = airport
        self.airline = airline
        self.flightNumber = flightNumber
        self.departureTime = departureTime
        self.time = time
    }
    
    @discardableResult convenience init?(tripRepresentation: TripRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(airport: tripRepresentation.airport,
                  date: tripRepresentation.date,
                  flightNumber: tripRepresentation.flightNumber,
                  numberOfTravelers: tripRepresentation.numberOfTravelers,
                  time: tripRepresentation.time,
                  context: context)
        
    }
}
