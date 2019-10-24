//
//  UserRepresentation.swift
//  Kids Fly
//
//  Created by Marc Jacques on 10/21/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import Foundation

struct Bearer: Codable {
    let token: String
}

struct UserRepresentation: Codable {
    
    let email: String?
    let password: String?
    let fullName: String?
    
    enum CodingKeys: String, CodingKey {
        case email
        case password
        case fullName
    }
    
}

extension UserRepresentation: Equatable {
    static func == (lhs: UserRepresentation, rhs: User) -> Bool {
        return lhs.email == rhs.email &&
            lhs.password == rhs.password &&
            lhs.fullName == rhs.fullName
        
    }
    
    static func == (lhs: User, rhs: UserRepresentation) -> Bool {
        return rhs == lhs
    }
    
    static func != (lhs: User, rhs: UserRepresentation) -> Bool {
        return rhs != lhs
    }
    
    static func != (lhs: UserRepresentation, rhs: User) -> Bool {
        return !(rhs == lhs)
    }
}
