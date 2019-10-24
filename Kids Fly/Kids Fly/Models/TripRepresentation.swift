//
//  Trip.swift
//  Kids Fly
//
//  Created by Marc Jacques on 10/22/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import Foundation

struct TripRepresentation: Codable {
    
    let airport: String?
    let airline: String?
    let flightNumber: String?
    let departureTime: String?
    let carryOnBags: Int32?
    let checkedBags: Int32?
    let children: Int32?
    let arrived: Bool?
    let enRoute: Bool?
    let identifier: Int32?
    
    enum CodingKeys: String, CodingKey {
        case airport
        case airline
        case flightNumber
        case departureTime
        case carryOnBags
        case checkedBags
        case children
        case arrived
        case enRoute = "en_route"
        case identifier = "id"
    }
    
    static func ==(lhs: TripRepresentation, rhs: Trip) -> Bool {
        return lhs.airport == rhs.airport &&
            lhs.airline == rhs.airline &&
            lhs.flightNumber == rhs.flightNumber &&
            lhs.departureTime == rhs.departureTime &&
            lhs.carryOnBags == rhs.carryOnBags &&
            lhs.checkedBags == rhs.checkedBags &&
            lhs.children == rhs.children &&
            lhs.arrived == rhs.arrived &&
            lhs.enRoute == rhs.enRoute &&
            lhs.identifier == rhs.identifier
    }
    
    static func ==(lhs: Trip, rhs: TripRepresentation) -> Bool {
        return rhs == lhs
    }

    static func !=(lhs: TripRepresentation, rhs: Trip) -> Bool {
        return !(rhs == lhs)
    }

    static func !=(lhs: Trip, rhs: TripRepresentation) -> Bool {
        return rhs != lhs
    }
}
