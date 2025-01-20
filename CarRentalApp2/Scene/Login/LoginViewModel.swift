//
//  LoginViewModel.swift
//  CarRentalApp2
//
//  Created by Elnur Mammadov on 20.01.25.
//

import Foundation
import RealmSwift

class LoginViewModel {
    let manager = UserDefaultsManager()
    private var users = [Users]()
    var success: (() -> Void)?
    var error: (() -> Void)?
    
    func fetchData(realm: Realm?) {
        if let data = realm?.objects(Users.self) {
            users.removeAll()
            users.append(contentsOf: data)
        }
    }
    
    func checkuser(email: String, password: String) {
        if users.contains(where: { $0.email == email && $0.password == password }) {
            guard let index = users.firstIndex(where: { $0.email == email && $0.password == password }) else { return }
            manager.setValue(value: index, key: .getUserIndex)
            success?()
        } else {
            error?()
        }
    }
}
