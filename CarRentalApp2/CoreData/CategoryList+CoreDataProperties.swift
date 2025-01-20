//
//  CategoryList+CoreDataProperties.swift
//  CarRentalApp2
//
//  Created by Elnur Mammadov on 19.01.25.
//
//

import Foundation
import CoreData


extension CategoryList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryList> {
        return NSFetchRequest<CategoryList>(entityName: "CategoryList")
    }

    @NSManaged public var image: String?
    @NSManaged public var isSelected: Bool
    @NSManaged public var name: String?
    @NSManaged public var size: Int64

}

extension CategoryList : Identifiable {

}
