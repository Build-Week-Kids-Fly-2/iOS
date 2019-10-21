//
//  UserRepresentation.swift
//  Kids Fly
//
//  Created by Marc Jacques on 10/21/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import Foundation

struct UserRepresentation: Codable {
    let email: String
    let password: String
    let fullName: String
    let address: String
    let phone: String
    let localAirport: String
}
