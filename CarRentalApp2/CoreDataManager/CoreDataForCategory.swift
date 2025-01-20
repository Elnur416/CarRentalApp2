//
//  CoreDataForCategory.swift
//  CarRentalApp2
//
//  Created by Elnur Mammadov on 19.01.25.
//

import Foundation
import CoreData

class CoreDataForCategory {
    var context = AppDelegate().persistentContainer.viewContext
    
    init (context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchData(completion: (([CategoryList]) -> Void)) {
        do {
            let data = try context.fetch(CategoryList.fetchRequest())
            completion(data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveData(category: CategoryModel) {
        let model = CategoryList(context: context)
        model.name = category.name
        model.image = category.image
        model.size = Int64(category.size ?? 0)
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
