//
//  UserDefaultsHelper.swift
//  Kids Fly
//
//  Created by Jake Connerly on 10/23/19.
//  Copyright © 2019 jake connerly. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
}
