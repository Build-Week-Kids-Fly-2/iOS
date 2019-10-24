//
//  TimePickerViewController.swift
//  Kids Fly
//
//  Created by Jake Connerly on 10/24/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

protocol TimePickerDelegate: AnyObject {
    func timeWasChosen(date: Date)
}

class TimePickerViewController: UIViewController {
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var selectDateButton: UIButton!
    
    var delegate: TimePickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func selectDateTapped(_ sender: UIButton) {
        self.delegate?.timeWasChosen(date: timePicker.date)
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupUI() {
        pickerContainerView.layer.cornerRadius = 30
        pickerContainerView.layer.shadowRadius = 15
        pickerContainerView.layer.shadowOffset = .zero
        pickerContainerView.layer.shadowOpacity = 0.2
    }

}
