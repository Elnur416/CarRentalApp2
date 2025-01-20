//
//  CarList+CoreDataProperties.swift
//  CarRentalApp2
//
//  Created by Elnur Mammadov on 19.01.25.
//
//

import Foundation
import CoreData


extension CarList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CarList> {
        return NSFetchRequest<CarList>(entityName: "CarList")
    }

    @NSManaged public var brand: String?
    @NSManaged public var category: String?
    @NSManaged public var engine: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var price: Double

}

extension CarList : Identifiable {

}
