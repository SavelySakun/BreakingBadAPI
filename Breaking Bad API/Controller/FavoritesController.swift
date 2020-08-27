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
    var quotes = [Quote(id: 1, text: "Loading...", author: "...", authorImg: "https://image.flaticon.com/icons/svg/2948/2948035.svg")]
    
    let quotesCoreData = QuotesCoreData()

    // MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        quotesCoreData.retrieveFavoritesQuote() { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.quotes = data
                    
                    print("DEBUG: data.count from \(#function): \(data.count)")
                    self.tableView.reloadData()
                }
            case .failure(_):
                break
            }
        }
    }
    
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
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteQuoteCell().cellReuseIdentifier, for: indexPath) as! FavoriteQuoteCell
        
        var quote = quotes[indexPath.row]
        
        print("QUOTES COUNT: \(quotes.count)")
        //print("DEBUG: quote text from \(#function): \(quote.text)")
        
        cell.nameLabel.text = quote.author
        cell.quoteLabel.text = quote.text
        
        print(quote.author)
        
        if quote.author == "Jesse Pinkman" {
            quote.authorImg = "https://vignette.wikia.nocookie.net/breakingbad/images/5/57/151015113000_660871736.jpeg/revision/latest?cb=20161221212557"
        }
        
        let imageURL = URL(string: quote.authorImg!)
        let avatarImageView: UIImageView = {
            let iv = UIImageView()
            iv.sd_setImage(with: imageURL)
            return iv
        }()

        cell.characterImageView.image = avatarImageView.image
        
        return cell
    }
    
    
    
    
}
