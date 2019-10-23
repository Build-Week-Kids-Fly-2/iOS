//
//  TripController.swift
//  Kids Fly
//
//  Created by Marc Jacques on 10/23/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import Foundation
import CoreData


enum PutType: String {
    case add
    case update
}

class TripController {
//    init() {
//        fetchTripsFromServer()
//    }
        
    // MARK: - Properties
    static let shared = TripController()
    let baseURL = URL(string:  "https://evening-island-60784.herokuapp.com/api/trips")!
    
    func createTrip() {
    }
}
