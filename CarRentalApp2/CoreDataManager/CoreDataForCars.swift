//
//  CoreDataForCars.swift
//  CarRentalApp2
//
//  Created by Elnur Mammadov on 19.01.25.
//

import Foundation
import CoreData

class CoreDataForCars {
    var context = AppDelegate().persistentContainer.viewContext
    
    init (context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchData(completion: (([CarList]) -> Void)) {
        do {
           let data = try context.fetch(CarList.fetchRequest())
            completion(data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveData(car: CarModel) {
        let model = CarList(context: context)
        model.name = car.name
        model.brand = car.brand
        model.category = car.category.name
        model.engine = car.engine
        model.image = car.image
        model.price = car.price ?? 0
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
