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
    case signIn
}

class SignInViewController: UIViewController {
    
    // MARK: - IBOutlets & Properties
    
    @IBOutlet weak var googleSignIn: UIButton!
    @IBOutlet weak var facebookSignIn: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInOrSignUpButton: UIButton!
    @IBOutlet weak var loginSignUpText: UILabel!
    @IBOutlet weak var signInOrSignUpControl: UISegmentedControl!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var fullNameLine: UIImageView!
    
    
    var apiController = APIController()
    var loginType = LoginType.signUp
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleButton(button: signInOrSignUpButton)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        fullNameTextField.delegate = self
        
    }
    
    // MARK: - IBActions & Methods
    
    func styleButton(button: UIButton) {
        button.layer.cornerRadius = 10
    }
    
    @IBAction func signUpOrSignIn1(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            loginType = .signIn
            signInOrSignUpButton.setTitle("Sign In", for: .normal)
            fullNameTextField.isHidden = true
            fullNameLine.isHidden = true
        } else {
            loginType = .signUp
            signInOrSignUpButton.setTitle("Sign Up", for: .normal)
            fullNameTextField.isHidden = false
            fullNameLine.isHidden = false
        }
    }
    
    @IBAction func createAccountOrSignIn(_ sender: UIButton) {
        if loginType == .signIn {
            login()
        } else {
            register()
        }
    }
    
    func register() {
        guard let email = emailTextField.text,
        let password = passwordTextField.text,
        let fullName = fullNameTextField.text,
        !email.isEmpty,
        !password.isEmpty,
        !fullName.isEmpty else { return }
        
        let user = UserRepresentation(email: email, password: password, fullName: fullName)
        
        apiController.signUp(with: user) { (error) in
            if let error = error {
                NSLog("Error signing up with:\(error)")
            }
            self.apiController.login(with: user) { (result) in
                if (try? result.get()) != nil {
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                    }
                } else {
                    NSLog("Error logging in with:\(result)")
                }
            }
        }
    }
    
    func login() {
        guard let email = emailTextField.text,
        let password = passwordTextField.text,
        !email.isEmpty,
        !password.isEmpty else { return }
        
        let user = UserRepresentation(email: email, password: password, fullName: nil)
        apiController.login(with: user) { (result) in
            if (try? result.get()) != nil {
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                NSLog("error logging in with:\(result)")
            }
        }
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




