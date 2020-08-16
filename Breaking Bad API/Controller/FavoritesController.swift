//
//  FavoritesController.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 16.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit

class FavoritesController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Favorite Quotes"
        navigationController?.navigationBar.prefersLargeTitles = true

        view.backgroundColor = .white
    }

}
