//
//  Models.swift
//  CarRentalApp2
//
//  Created by Elnur Mammadov on 19.01.25.
//

import Foundation
import RealmSwift

struct CarModel: Codable {
    let brand: String?
    let engine: String?
    let image: String?
    let name: String?
    let price: Double?
    let category: CategoryModel
}

struct CategoryModel: Codable {
    let image: String?
    let name: String?
    let size: Int?
}

class Users: Object {
    @Persisted var fullname : String?
    @Persisted var birthdate: String?
    @Persisted var phone: String?
    @Persisted var email: String?
    @Persisted var password: String?
}
