//
//  RegisterViewModel.swift
//  CarRentalApp2
//
//  Created by Elnur Mammadov on 20.01.25.
//

import Foundation
import RealmSwift

class RegisterViewModel {
    private var users = [Users]()
    var error: (() -> Void)?
    var success: (() -> Void)?
    
    func getPath(realm: Realm?) {
        if let path = realm?.configuration.fileURL {
            print(path)
        }
    }
    
    func fetchItems(realm: Realm?) {
        if let data = realm?.objects(Users.self) {
            users.removeAll()
            users.append(contentsOf: data)
        }
    }
    
    func saveData(realm: Realm?, user: Users) {
        if users.contains(where: { $0.email == user.email && $0.password == user.password && $0.fullname == user.fullname && $0.phone == user.phone && $0.birthdate == user.birthdate }) {
            error?()
        } else {
            try? realm?.write {
                realm?.add(user)
            }
        }
    }
}
