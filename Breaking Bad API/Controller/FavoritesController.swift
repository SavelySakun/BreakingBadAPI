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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchDataToTableView()
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
    
    func fetchDataToTableView() {
        print("\(#function)")
        quotesCoreData.retrieveFavoritesQuotes() { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.quotes = data
                    self.tableView.reloadData()
                }
            case .failure(_):
                break
            }
        }
    }
    
    // MARK: - Selectors
    @objc func addToFavorite(sender: UIButton) {
        
        let cellNumber = sender.tag
        
        // How to reach cell in tableView
        let indexPath = IndexPath(row: cellNumber, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! FavoriteQuoteCell
        
        let quoteId = quotes[cellNumber].id
        let quoteSavedStatus = quotes[cellNumber].isSavedToFavorites
        
        let authorImg = quotes[cellNumber].authorImg!
        
        quotesCoreData.updateIsSavedToFavorites(quoteId: quoteId, authorImg: authorImg, currentFavoriteStatus: quoteSavedStatus!)
        
        fetchDataToTableView()
    }

}

extension FavoritesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteQuoteCell().cellReuseIdentifier, for: indexPath) as! FavoriteQuoteCell
        
        var quote = quotes[indexPath.row]
                
        cell.nameLabel.text = quote.author
        cell.quoteLabel.text = quote.text
                
        if quote.author == "Jesse Pinkman" {
            quote.authorImg = "https://vignette.wikia.nocookie.net/breakingbad/images/5/57/151015113000_660871736.jpeg/revision/latest?cb=20161221212557"
        }
        
        let imageURL = URL(string: quote.authorImg!)
        let avatarImageView: UIImageView = {
            let iv = UIImageView()
            iv.sd_setImage(with: imageURL)
            return iv
        }()
        
        cell.deleteButton.addTarget(self, action: #selector(addToFavorite(sender:)), for: .touchUpInside)

        cell.characterImageView.image = avatarImageView.image
        
        return cell
    }
    
    
    
    
}
