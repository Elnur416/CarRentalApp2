//
//  AccountViewModel.swift
//  CarRentalApp2
//
//  Created by Elnur Mammadov on 20.01.25.
//

import Foundation
import RealmSwift

class AccountViewModel {
    let manager = UserDefaultsManager()
    var users = [Users]()
    
    func fetchData(realm: Realm?) {
        if let data = realm?.objects(Users.self) {
            users.removeAll()
            users.append(contentsOf: data)
        }
    }
    
    
}
