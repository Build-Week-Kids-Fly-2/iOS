//
//  BookTripViewController.swift
//  Kids Fly
//
//  Created by Jake Connerly on 10/21/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

class BookTripViewController: UIViewController {

    @IBOutlet weak var serviceAirportTextField: UITextField!
    @IBOutlet weak var numberOfTravelersTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var flightNumberTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        serviceAirportSeleted()
        // Do any additional setup after loading the view.
    }
    
    
    
    @objc func serviceAirportSeleted() {
        if serviceAirportTextField.isEditing {
            performSegue(withIdentifier: "ShowAirports", sender: self)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    @IBAction func planTripButtonTapped(_ sender: Any) {
    }
    
}

extension BookTripViewController:UITextFieldDelegate {
}
