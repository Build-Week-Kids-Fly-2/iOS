//
//  DatePickerViewController.swift
//  Kids Fly
//
//  Created by Jake Connerly on 10/22/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

protocol DatePickerDelegate: AnyObject {
    func dateWasChosen(date: Date)
}

class DatePickerViewController: UIViewController {
    
    // MARK: - IBOutlets & Properties

    @IBOutlet weak var flightDatePicker: UIDatePicker!
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var selectDateButton: UIButton!
    
    var delegate: DatePickerDelegate?
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - IBActions & Methods
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SelectDateTapped(_ sender: UIButton) {
        self.delegate?.dateWasChosen(date: flightDatePicker.date)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func clearViewTapped(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupUI() {
        modalView.layer.cornerRadius = 30
        modalView.layer.shadowRadius = 15
        modalView.layer.shadowOffset = .zero
        modalView.layer.shadowOpacity = 0.2
        
        selectDateButton.layer.cornerRadius = 10
        //selectDateButton.layer.borderWidth = 2
    }
}
