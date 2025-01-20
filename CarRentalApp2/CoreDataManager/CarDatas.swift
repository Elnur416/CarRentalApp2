//
//  CarDatas.swift
//  CarRentalApp2
//
//  Created by Elnur Mammadov on 19.01.25.
//

import Foundation

class CarDatas {
    let carData = CoreDataForCars(context: AppDelegate().persistentContainer.viewContext)
    let categoryData = CoreDataForCategory(context: AppDelegate().persistentContainer.viewContext)
    
   
    func loadData() {
//        Categories
        let category1 = CategoryModel(image: "sedan",
                                      name: "Sedan",
                                      size: 2)
        categoryData.saveData(category: category1)
        
        let category2 = CategoryModel(image: "coupe",
                                      name: "Coupe",
                                      size: 2)
        categoryData.saveData(category: category2)
        
        let category3 = CategoryModel(image: "sport",
                                      name: "Sport",
                                      size: 2)
        categoryData.saveData(category: category3)
        
        let category4 = CategoryModel(image: "suv",
                                      name: "SUV",
                                      size: 2)
        categoryData.saveData(category: category4)
        
        let category5 = CategoryModel(image: "pickup",
                                      name: "Pickup",
                                      size: 2)
        categoryData.saveData(category: category5)
        
        
//        Cars
        let car1 = CarModel(brand: "Mercedes",
                            engine: "V8",
                            image: "amg G63",
                            name: "Amg G63",
                            price: 500,
                            category: category4)
        carData.saveData(car: car1)
        
        let car2 = CarModel(brand: "Ford",
                            engine: "3.5-liter V-6",
                            image: "raptor",
                            name: "Raptor",
                            price: 500,
                            category: category5)
        carData.saveData(car: car2)
        
        let car3 = CarModel(brand: "Toyota",
                            engine: "1.8-liter I-4",
                            image: "corolla",
                            name: "Corolla",
                            price: 300,
                            category: category1)
        carData.saveData(car: car3)
        
        let car4 = CarModel(brand: "Toyota",
                             engine: "201.15bhp@3000",
                             image: "hilux",
                             name: "Hilux",
                             price: 350,
                             category: category5)
        carData.saveData(car: car4)
        
        let car5 = CarModel(brand: "Lamborghini",
                            engine: "V12",
                            image: "aventador",
                            name: "Aventador",
                            price: 700,
                            category: category3)
        carData.saveData(car: car5)
        
        let car6 = CarModel(brand: "Mercedes",
                            engine: "V-8",
                            image: "s-class",
                            name: "S-class",
                            price: 450,
                            category: category2)
        carData.saveData(car: car6)
    }
}
