//
//  SearchViewModel.swift
//  CarRentalApp2
//
//  Created by Elnur Mammadov on 19.01.25.
//

import Foundation

class SearchViewModel {
    private let carData = CoreDataForCars(context: AppDelegate().persistentContainer.viewContext)
    var cars = [CarList]()
    var isSearchActive: Bool = false
    var searchedCars = [CarList]()
    
    func fetchDataForCar() {
        carData.fetchData { data in
            self.cars = data
        }
    }
}
