//
//  CheckingInViewController.swift
//  Kids Fly
//
//  Created by Marc Jacques on 10/24/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

class CheckingInViewController: UIViewController {

    @IBOutlet weak var bellButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var checkInButton: UIButton!
    @IBOutlet weak var greetTravelerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        styleButton(button: checkInButton)

        // Do any additional setup after loading the view.
    }
    
    func styleButton(button: UIButton) {
           button.setTitleColor(.black, for: .normal)
           button.layer.cornerRadius = 10
       }
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func checkInTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowTripProgress", sender: self)
    }
    
    @IBAction func menuButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func bellButtonTapped(_ sender: UIButton) {
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
