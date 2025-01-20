//
//  UserDefaultsManager.swift
//  CarRentalApp2
//
//  Created by Elnur Mammadov on 19.01.25.
//

import Foundation

class UserDefaultsManager {
    enum UserDefaultsTypes: String {
        case isLoggedIn = "loggedIn"
        case isDataLoaded = "dataLoaded"
        case getUserIndex = "userIndex"
    }
    
    func setValue(value: Any, key: UserDefaultsTypes) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func getBool(key: UserDefaultsTypes) -> Bool {
        UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    func getUserIndex(key: UserDefaultsTypes) -> Int {
        UserDefaults.standard.integer(forKey: key.rawValue)
    }
}
