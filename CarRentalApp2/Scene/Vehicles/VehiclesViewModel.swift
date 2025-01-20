//
//  VehiclesViewModel.swift
//  CarRentalApp2
//
//  Created by Elnur Mammadov on 19.01.25.
//

import Foundation

class VehiclesViewModel {
    private let mainData = CarDatas()
    let manager = UserDefaultsManager()
    private let carData = CoreDataForCars(context: AppDelegate().persistentContainer.viewContext)
    private let categoryData = CoreDataForCategory(context: AppDelegate().persistentContainer.viewContext)
    var cars = [CarList]()
    var categories = [CategoryList]()
    var isSearchActive: Bool = false
    var searchedCars = [CarList]()
    var selectedCategory: String?
    var carsForSelectedCategory = [CarList]()
    
    func loadData() {
        mainData.loadData()
        manager.setValue(value: true, key: .isDataLoaded)
    }
    
    func fetchDataForCar() {
        carData.fetchData { data in
            self.cars = data
        }
    }
    
    func fetchDataForCategory() {
        categoryData.fetchData { data in
            self.categories = data
        }
    }
}
