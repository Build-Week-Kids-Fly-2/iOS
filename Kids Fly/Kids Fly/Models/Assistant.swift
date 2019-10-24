//
//  Assistant.swift
//  Kids Fly
//
//  Created by Jake Connerly on 10/24/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import UIKit

struct Assistant: Codable, Hashable {
    let name: String
    let languages: [String]
    let abilities: [String]
    let backgroundCheck: String
    let image: Data
    let jobComplete: String
}
