//
//  SignInViewController.swift
//  Kids Fly
//
//  Created by Marc Jacques on 10/21/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit
import Foundation

enum LoginType {
    case signUp
    case logIn
}

class SignInViewController: UIViewController {
    
    var loginType = LoginType.signUp
    
    @IBOutlet weak var signUpOrLogInLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInOrSignUpButton: UIButton!
    @IBOutlet weak var loginSignUpText: UILabel!
    @IBOutlet weak var signInOrSignUp: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleButton(button: signInOrSignUpButton)
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func styleButton(button: UIButton) {
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 25
        button.layer.borderWidth = 3
        button.backgroundColor = #colorLiteral(red: 0.9717740417, green: 0.8278650641, blue: 0.6093913913, alpha: 1)
    }
    
    @IBAction func createAccountButtonTapped(_ sender: UIButton) {
        
    }
}
// MARK: - Text Field Delegate

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
            return true
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            return true
        } else {
            return false
        }
    }
}

