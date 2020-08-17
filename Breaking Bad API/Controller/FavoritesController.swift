//
//  FavoritesController.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 16.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit

class FavoritesController: UIViewController {
    
    // MARK: - Properties
    let tableView = UITableView()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI() {
        navigationItem.title = "Favorite Quotes"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        configureTableView()
    }
    
    func configureTableView() {
        
        tableView.frame = view.frame
        tableView.dataSource = self
        tableView.register(FavoriteQuoteCell.self, forCellReuseIdentifier: FavoriteQuoteCell().cellReuseIdentifier)
        
        
    }

}

extension FavoritesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteQuoteCell().cellReuseIdentifier, for: indexPath) as! FavoriteQuoteCell
        
        cell.nameLabel.text = "Walter White"
        
        cell.characterImageView.image = #imageLiteral(resourceName: "testIMG")
        cell.quoteLabel.text = "I am not in danger, Skyler. I am the danger!"
        
        
        return cell
        
    }
    
    
    
    
}
