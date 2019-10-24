//
//  EmailSupportViewController.swift
//  Kids Fly
//
//  Created by Marc Jacques on 10/24/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

class EmailSupportViewController: UIViewController {

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var gotItButton: UIButton!
     @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var search2: UISearchBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleButton(button: gotItButton)
        styleButton(button: sendButton)
        // Do any additional setup after loading the view.
    }
    
    func styleButton(button: UIButton) {
           button.setTitleColor(.black, for: .normal)
           button.layer.cornerRadius = 10
       }
    

    
    
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowMessageSentConfirmation", sender: self)
    }
   
    @IBAction func bellButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func menuButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func bell2buttonTapped(_ sender: UIButton) {
    }
    
    @IBAction func menu2Button(_ sender: UIButton) {
    }
    
    @IBAction func gotItButtonTapped(_ sender: UIButton) {
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
