//
//  BookTripViewController.swift
//  Kids Fly
//
//  Created by Jake Connerly on 10/21/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit
import DropDown

class BookTripViewController: UIViewController {
    
    // MARK: - IBOutlets & Properties

    @IBOutlet weak var serviceAirportTextField: UITextField!
    @IBOutlet weak var numberOfTravelersTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var flightNumberTextField: UITextField!
    @IBOutlet weak var airlineTextField: UITextField!
    
    let tripController = TripController.shared
    
    let dropDownAirports = DropDown()
    let dropDownNumberOfTravelers = DropDown()
    var trip: Trip?
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM, yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }
    
    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDropDowns()
        setUpTextFields()
    }
    
    // MARK: - IBActions & Methods
    
    func setUpDropDowns() {
        //Airport DropDown
        dropDownAirports.anchorView = serviceAirportTextField
        dropDownAirports.dismissMode = .automatic
        dropDownAirports.dataSource = ["DFW: Dallas/Fort Worth International Airport", "LAX: Los Angeles International Airport", "LGA: LaGuardia Airport", "DIA: Denver International Airport", "ATL: Atlanta International Airport"]
        //NumberOfTravelers DropDown
        dropDownNumberOfTravelers.anchorView = numberOfTravelersTextField
        dropDownNumberOfTravelers.dismissMode = .automatic
        dropDownNumberOfTravelers.dataSource = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
        
    }
    
    func setUpTextFields() {
        serviceAirportTextField.delegate = self
        numberOfTravelersTextField.delegate = self
        dateTextField.delegate = self
        timeTextField.delegate = self
    }
    
    @IBAction func planTripButtonTapped(_ sender: Any) {
       }
    
    func createNewTrip() {
        //setup Airport
        guard let serviceAirport = serviceAirportTextField.text else { return }
        var airport = serviceAirport
        airport.removeFirst(4)
        
        //setup number of Travelers
        guard let numTravelersString = numberOfTravelersTextField.text,
            let numberOfTravelers = Int(numTravelersString) else { return }
        
        //setup Departure Date and Time
        guard let date = dateTextField.text,
            let time = timeTextField.text else { return }
        let departureTime = "\(date) at \(time)"
        
        guard let flightNumber = flightNumberTextField.text,
            let airline = airlineTextField.text else { return }
        
        self.trip = Trip(airport: airport, airline: airline, flightNumber: flightNumber, departureTime: departureTime, carryOnBags: 0, checkedBags: 0, children: Int32(numberOfTravelers), arrived: false, enRoute: false, identifier: nil)
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDatePicker" {
            guard let datePickerVC = segue.destination as? DatePickerViewController else { return }
            datePickerVC.delegate = self
        }
        if segue.identifier == "ShowTimePicker" {
            guard let timePickerVC = segue.destination as? TimePickerViewController else { return }
            timePickerVC.delegate = self
        }
        if segue.identifier == "HireAssistantSegue" {
            createNewTrip()
            guard let hireVC = segue.destination as? HireViewController else { return }
            hireVC.trip = trip
            print("\(trip?.airline)")
        }
    }
}

extension BookTripViewController:UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case serviceAirportTextField:
            //serviceAirportTextField.becomeFirstResponder()
            dropDownAirports.show()
            dropDownAirports.selectionAction = { (index: Int, item: String) in
                self.serviceAirportTextField.text = item
            }
        case numberOfTravelersTextField:
            //numberOfTravelersTextField.becomeFirstResponder()
            dropDownNumberOfTravelers.show()
            dropDownNumberOfTravelers.selectionAction = { (index: Int, item: String) in
                self.numberOfTravelersTextField.text = item
            }
        case dateTextField:
            dateTextField.resignFirstResponder()
            performSegue(withIdentifier: "ShowDatePicker", sender: self)
        case timeTextField:
            timeTextField.resignFirstResponder()
            performSegue(withIdentifier: "ShowTimePicker", sender: self)
        default:
            break
        }
    }
}

extension BookTripViewController: DatePickerDelegate {
    func dateWasChosen(date: Date) {
        dateTextField.text = dateFormatter.string(from: date)
    }
}

extension BookTripViewController: TimePickerDelegate {
    func timeWasChosen(date: Date) {
        timeTextField.text = timeFormatter.string(from: date)
    }
}
