//
//  TripController.swift
//  Kids Fly
//
//  Created by Jake Connerly on 10/23/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import Foundation
import CoreData



class TripController {
    
    static let shared = TripController()
    let baseURL = URL(string: "https://evening-island-60784.herokuapp.com/api")!
    
    //MARK: - Create Trip
    
    func createTrip(airport: String, airline: String, flightNumber: String, departureTime: String, carryOnBags: Int32, checkedBags: Int32, children: Int32, arrived: Bool, enRoute: Bool) {
        let tripRepresentation = TripRepresentation(airport: airport, airline: airline, flightNumber: flightNumber, departureTime: departureTime, carryOnBags: carryOnBags, checkedBags: checkedBags, children: children, arrived: arrived, enRoute: enRoute, identifier: nil)
        
        post(tripRepresentation: tripRepresentation)
    }
    
    //MARK: - Update Trip
    
    func updateTrip(trip: Trip, airport: String, airline: String, flightNumber: String, departureTime: String, carryOnBags: Int32, checkedBags: Int32, children: Int32, arrived: Bool, enRoute: Bool) {
        
        let tripRepresentation = TripRepresentation(airport: airport, airline: airline, flightNumber: flightNumber, departureTime: departureTime, carryOnBags: carryOnBags, checkedBags: checkedBags, children: children, arrived: arrived, enRoute: enRoute, identifier: trip.identifier)
        trip.airport = airport
        trip.airline = airline
        trip.flightNumber = flightNumber
        trip.departureTime = departureTime
        trip.carryOnBags = carryOnBags
        trip.checkedBags = checkedBags
        trip.children = children
        trip.arrived = arrived
        trip.enRoute = enRoute
        
        do{
            try CoreDataStack.shared.save()
        } catch {
            NSLog("Error saving context when updating trip:\(error)")
        }
        
        put(trip: tripRepresentation)
    }
    
    //MARK: - Delete Trip
    
    func deleteTrip(trip: Trip, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        deleteTripFromServer(trip: trip)
        context.performAndWait {
            context.delete(trip)
            
            do{
                try CoreDataStack.shared.save(context: context)
            } catch {
                NSLog("error saving context when deleting trip:\(error)")
            }
        }
    }
    
    //MARK: - Fetch Trip From Server
    
    func fetchTripsFromServer(completion: @escaping () -> Void = {}) {
        let token: String? = KeychainWrapper.standard.string(forKey: "token")
        
        let requestURL = baseURL.appendingPathComponent("user_trips")
        var request = URLRequest(url:requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = token {
            request.setValue("\(token)", forHTTPHeaderField: "Authorization")
        } else {
            completion()
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                NSLog("Bad response fetching trips with response code:\(response.statusCode)")
                completion()
                return
            }
            
            if let error = error {
                NSLog("Error fetching trips from server:\(error)")
            }
            
            guard let data = data else {
                NSLog("No data returned from fetching trips from server:\(error)")
                completion()
                return
            }
            
            do{
                let decoer = JSONDecoder()
                let tripRepresentations = try decoer.decode([TripRepresentation].self, from: data)
                completion()
                self.updateTrips(with: tripRepresentations)
                try CoreDataStack.shared.save()
            } catch {
                NSLog("Error decoding trip representations:\(error)")
                completion()
                return
            }
        }.resume()
    }
    
    //MARK: - Post Trip to Server
    
    func post(tripRepresentation: TripRepresentation, completion: @escaping () -> Void = { }) {
        let requestURL = baseURL.appendingPathComponent("user_trips/add")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let token: String? = KeychainWrapper.standard.string(forKey: "token")
        
        if let token = token {
            request.setValue("\(token)", forHTTPHeaderField: "Authorization")
        }
        
        do {
            let encoder = JSONEncoder()
            request.httpBody = try encoder.encode(tripRepresentation)
        } catch {
            NSLog("Error encoding trip \(tripRepresentation.airport!) on \(tripRepresentation.departureTime!) with error:\(error)")
            completion()
            return
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                NSLog("Error POSTing trip to server:\(error)")
                completion()
                return
            }
            
                do{
                    
                    let moc = CoreDataStack.shared.mainContext
                    moc.performAndWait {
                        guard let airport = tripRepresentation.airport,
                            let airline = tripRepresentation.airline,
                            let flightNumber = tripRepresentation.flightNumber,
                            let departureTime = tripRepresentation.departureTime,
                            let carryOnBags = tripRepresentation.carryOnBags,
                            let checkedBags = tripRepresentation.checkedBags,
                            let children = tripRepresentation.children,
                            let arrived = tripRepresentation.arrived,
                            let enRoute = tripRepresentation.enRoute else { return }
                        
                        Trip(airport: airport, airline: airline, flightNumber: flightNumber, departureTime: departureTime, carryOnBags: carryOnBags, checkedBags: checkedBags, children: children, arrived: arrived, enRoute: enRoute, identifier: nil, context: moc)
                    }
                    try CoreDataStack.shared.save(context: moc)
                } catch {
                    NSLog("Error decoding trip and saving trip:\(error)")
                }
            completion()
        }.resume()
    }
    
    //MARK: - Update Trip in Server
    
    func put(trip: TripRepresentation, completion: @escaping () -> Void = { }) {
        guard let identifer = trip.identifier else { return }
        
        let requestURL = baseURL.appendingPathComponent("user_trips/\(identifer)")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let token: String? = KeychainWrapper.standard.string(forKey: "token")
        
        if let token = token {
            request.setValue("\(token)", forHTTPHeaderField: "Authorization")
        }
        
        do{
            request.httpBody = try JSONEncoder().encode(trip)
        } catch {
            NSLog("Error encoding trip to \(trip.airport) at \(trip.departureTime):\(error)")
            completion()
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                NSLog("Error PUting Trip in server:\(error)")
                completion()
                return
            }
            completion()
        }.resume()
    }
    
    //MARK: - Delete Trip From Server
    
    func deleteTripFromServer(trip: Trip, completion: @escaping (Error?) -> Void = { _ in }) {
        
        let requestURL = baseURL.appendingPathComponent("user_trips/\(trip.identifier)")
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.delete.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let token: String? = KeychainWrapper.standard.string(forKey: "token")
        
        if let token = token {
            request.setValue("\(token)", forHTTPHeaderField: "Authorization")
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                NSLog("Error deleting tour from server: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    //MARK: - Fetch Single Trip
    
    private func fetchSingleTripFromPersistentStore(identifier: Int32, context: NSManagedObjectContext) -> Trip? {
        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "identifier == %i", identifier)
        
        var trip: Trip? = nil
        context.performAndWait {
            do{
                trip = try context.fetch(fetchRequest).first
            } catch {
                NSLog("Error fetching Trip with identifier \(identifier):\(error)")
            }
        }
        return trip
    }
    
    //MARK: - Update Trip
    
    private func update(trip: Trip, tripRepresentation: TripRepresentation) {
        trip.airport = tripRepresentation.airport
        trip.airline = tripRepresentation.airline
        trip.flightNumber = tripRepresentation.flightNumber
        trip.departureTime = tripRepresentation.departureTime
        trip.carryOnBags = tripRepresentation.carryOnBags!
        trip.checkedBags = tripRepresentation.checkedBags!
        trip.children = tripRepresentation.children!
        trip.arrived = tripRepresentation.arrived!
        trip.enRoute = tripRepresentation.enRoute!
        guard let identifer = tripRepresentation.identifier else { return }
        trip.identifier = identifer
    }
    
    //MARK: - Update Trips
    
    private func updateTrips(with tripRepresentations: [TripRepresentation], context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        context.performAndWait {
            for tripRep in tripRepresentations {
                guard let identifier = tripRep.identifier else { return }
                let trip = fetchSingleTripFromPersistentStore(identifier: identifier, context: context)
                
                if let trip = trip {
                    if trip != tripRep {
                        update(trip: trip, tripRepresentation: tripRep)
                    }
                } else {
                    Trip(tripRepresentation: tripRep)
                }
                
            }
        }
    }
}
