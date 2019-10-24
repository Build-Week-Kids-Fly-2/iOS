//
//  ReviewTripViewController.swift
//  Kids Fly
//
//  Created by Jake Connerly on 10/22/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

class ReviewTripViewController: UIViewController {
    
    var tripController = TripController.shared
    
    var trip: Trip? {
        didSet {
            updateViews()
        }
    }
    var assistant: Assistant?
    
    @IBOutlet weak var destinationNameHeaderLabel: UILabel!
    @IBOutlet weak var departureTimeHeaderLabel: UILabel!
    
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var assistantNameLabel: UILabel!
    @IBOutlet weak var departureDateLabel: UILabel!
    @IBOutlet weak var departureTimeLabel: UILabel!
    @IBOutlet weak var numberOfTravelersLabel: UILabel!
    @IBOutlet weak var flightNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    @IBAction func editButtonTapped(_ sender: Any) {
    }
    
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        guard let trip = trip,
            let airport = trip.airport,
            let airline = trip.airline,
            let flightNumber = trip.flightNumber,
            let departureTime = trip.departureTime
            else { return }
        tripController.createTrip(airport: airport, airline: airline, flightNumber: flightNumber, departureTime: departureTime, carryOnBags: trip.carryOnBags, checkedBags: trip.checkedBags, children: trip.children, arrived: trip.arrived, enRoute: trip.enRoute)
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func updateViews() {
        
        guard let trip = trip,
              let assistant = assistant else { return }
        
        destinationNameHeaderLabel.text = "Review Your Trip to \(trip.airport)"
        assistantNameLabel.text = assistant.name
        departureTimeHeaderLabel.text = trip.departureTime
        departureTimeLabel.text = trip.departureTime
        
        destinationLabel.text = trip.airport
        departureDateLabel.text = trip.departureTime
        numberOfTravelersLabel.text = "\(trip.children) Passengers"
        flightNumberLabel.text = trip.flightNumber
    }
}
