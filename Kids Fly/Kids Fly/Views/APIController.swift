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


class APIController {
    
    // MARK: - Properties
    
    let baseURL = URL(string: "https://evening-island-60784.herokuapp.com/api")!
    var user: UserRepresentation?
    var token: String?
    
    //MARK: - Sign Up
    
    func signUp(with user: UserRepresentation, completion: @escaping (NetworkError?) -> Void) {
        
        let signUpURL = baseURL.appendingPathComponent("auth/register")
        
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
                response.statusCode != 201 {
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
        
        do{
            self.user = user
            let moc = CoreDataStack.shared.mainContext
            moc.performAndWait {
                User(userRepresentation: self.user!)
            }
            try CoreDataStack.shared.save(context: moc)
        } catch {
            completion(.noDecode)
        }
    }
    
    //MARK: - Log In
    
    func login(with user: UserRepresentation, completion: @escaping (Result<String, NetworkError>) -> Void) {

        let loginURL = baseURL.appendingPathComponent("auth/login")
 
        var request = URLRequest(url: loginURL)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        
        do {
            request.httpBody = try encoder.encode(user)
        } catch {
            NSLog("Error encoding user object: \(error)")
            completion(.failure(.encodingError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200 {
                print("\(response.statusCode)")
                completion(.failure(.responseError))
                return
            }
            
            if let error = error {
                NSLog("Error logging in: \(error)")
                completion(.failure(.otherError(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let bearer = try JSONDecoder().decode(Bearer.self, from: data)
                self.token = bearer.token
                self.user = user
                let moc = CoreDataStack.shared.mainContext
                
                moc.performAndWait {
                    User(userRepresentation: self.user!)
                }
                try CoreDataStack.shared.save(context: moc)
                if let token = self.token {
                    print(token)
                    KeychainWrapper.standard.set(token, forKey: "token")
                    completion(.success(token))
                }
            } catch {
                NSLog("error decoding data:\(error)")
                completion(.failure(.noDecode))
                return
            }
        }.resume()
    }
}

