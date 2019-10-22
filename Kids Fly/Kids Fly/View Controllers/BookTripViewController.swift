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
    
    let dropDownAirports = DropDown()
    let dropDownNumberOfTravelers = DropDown()
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDropDowns()
        serviceAirportTextField.delegate = self
        numberOfTravelersTextField.delegate = self
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
    
    @IBAction func planTripButtonTapped(_ sender: Any) {
       }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
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
        
        default:
            break
        }
    }
}
