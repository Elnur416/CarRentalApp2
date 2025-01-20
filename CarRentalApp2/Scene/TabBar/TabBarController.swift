//
//  TabBarController.swift
//  CarRentalApp2
//
//  Created by Elnur Mammadov on 18.01.25.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabs()
    }

    private func configureTabs() {
        let vc1 = VehiclesController()
        let vc2 = SearchController()
        let vc3 = AccountController()
        
        //Set tab Images
        vc1.tabBarItem.image = UIImage(systemName: "steeringwheel")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.tabBarItem.image = UIImage(systemName: "person.fill")
        
        //Set title
        vc1.tabBarItem.title = "Vehicles"
        vc2.tabBarItem.title = "Search"
        vc3.tabBarItem.title = "Account"
        
        //Navigation controllers
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        tabBar.tintColor = UIColor(named: "maincolour")
        tabBar.backgroundColor = .white
        
        setViewControllers([nav1, nav2, nav3], animated: true)
    }
}
