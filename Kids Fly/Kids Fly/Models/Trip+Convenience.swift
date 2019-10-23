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
            let date = date,
            let flightNumber = flightNumber,
            let numberOfTravelers = numberOfTravelers,
            let time = time
            else { return nil }
        return TripRepresentation(airport: airport, date: date, flightNumber: flightNumber, numberOfTravelers: numberOfTravelers, time: time)
    }
    
    convenience init(airport: String,
                     date: String, flightNumber: String, numberOfTravelers: String, time: String,context: NSManagedObjectContext) {
        self.init(context: context)
        self.airport = airport
        self.date = date
        self.flightNumber = flightNumber
        self.numberOfTravelers = numberOfTravelers
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
