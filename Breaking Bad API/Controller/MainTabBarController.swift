//
//  MainTabBarController.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 16.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarSetup()
    }
    
    
    // MARK: - Helpers
    func tabBarSetup() {
        
        let charactersController = createNavigationController(vc: CharactersController(), image: UIImage(systemName: "person.circle.fill"), tabBarTitle: "Characters")
        charactersController.navigationItem.title = "Characters"
        
        let favoritesController = createNavigationController(vc: FavoritesController(), image: UIImage(systemName: "heart.circle.fill"), tabBarTitle: "Favorite Quotes")
    
        viewControllers = [charactersController, favoritesController]
    }
}

extension UITabBarController {
    
    func createNavigationController(vc: UIViewController, image: UIImage!, tabBarTitle: String) -> UINavigationController {
        let viewController = vc
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = image
        navController.title = tabBarTitle
        return navController
    }
}
