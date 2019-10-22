//
//  APIController.swift
//  Kids Fly
//
//  Created by Marc Jacques on 10/22/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import Foundation
import UIKit

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}

enum NetworkError: Error {
    case encodingError
    case responseError
    case otherError(Error)
    case noData
    case noDecode
    case noToken
}

// "Model" Controller
class APIController {
    
    let baseURL = URL(string: " ")!
    var user: Int?
    var bearer: Bearer?
    
    // The Error? in the completion closure lets us return an error to the view controller for further error handling.
    func signUp(with user: User, completion: @escaping (NetworkError?) -> Void) {
        
        let signUpURL = baseURL
//            .appendingPathComponent("users")
//            .appendingPathComponent("signup")
        
        var request = URLRequest(url: signUpURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        
        do {
            // Convert the User object into JSON data.
            let userData = try encoder.encode(user)
            
            // Attach the user JSON to the URLRequest
            request.httpBody = userData
        } catch {
            NSLog("Error encoding user: \(error)")
            completion(.encodingError)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(.responseError)
                return
            }
            
            if let error = error {
                NSLog("Error creating user on server: \(error)")
                completion(.otherError(error))
                return
            }
            completion(nil)
            }.resume()
    }
    
    func login(with user: User, completion: @escaping (NetworkError?) -> Void) {
        
        // Set up the URL
        
        let loginURL = baseURL
            .appendingPathComponent("users")
            .appendingPathComponent("login")
        
        // Set up a request
        
        var request = URLRequest(url: loginURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        
        do {
            request.httpBody = try encoder.encode(user)
        } catch {
            NSLog("Error encoding user object: \(error)")
            completion(.encodingError)
            return
        }
        
        // Perform the request
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Handle errors
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                completion(.responseError)
                return
            }
            
            if let error = error {
                NSLog("Error logging in: \(error)")
                completion(.otherError(error))
                return
            }
            
            // (optionally) handle the data returned
            
            guard let data = data else {
                completion(.noData)
                return
            }
            
            do {
                let bearer = try JSONDecoder().decode(Bearer.self, from: data)
                self.bearer = bearer
            } catch {
                completion(.noDecode)
                return
            }
            completion(nil)
        }.resume()
    }
}

