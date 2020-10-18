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
    // TableView
    let tableView = UITableView()
    var quotes = [Quote]()
    
    // CoreData
    let quotesCoreData = QuotesCoreData()
    let favoriteQuotesCoreData = FavoriteQuoteCoreData()

    
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
        
        tableView.dataSource = self
        tableView.register(FavoriteQuoteCell.self, forCellReuseIdentifier: FavoriteQuoteCell().cellReuseIdentifier)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let tableViewConstraints: [NSLayoutConstraint] = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ]
        
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
    func fetchDataToTableView() {        
        favoriteQuotesCoreData.retrieveFavoritesQuotes() { result in
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
    @objc func updateFavorites(sender: UIButton) {
        
        let cellNumber = sender.tag
        let quoteId = quotes[cellNumber].id
        let quoteSavedStatus = quotes[cellNumber].isSavedToFavorites
        let authorImg = quotes[cellNumber].authorImg!
        
        favoriteQuotesCoreData.updateIsSavedToFavorites(quoteId: quoteId, authorImg: authorImg, currentFavoriteStatus: quoteSavedStatus!)
        
        quotes.remove(at: cellNumber)
        tableView.reloadData()
    }
}

extension FavoritesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteQuoteCell().cellReuseIdentifier, for: indexPath) as! FavoriteQuoteCell
        
        cell.selectionStyle = .none
        cell.contentView.isUserInteractionEnabled = false
        
        let quote = quotes[indexPath.row]
        cell.nameLabel.text = quote.author
        cell.quoteLabel.text = quote.text
        
        let imageURL = URL(string: quote.authorImg!)
        
        cell.characterImageView.sd_setImage(with: imageURL)
        
        cell.deleteButton.tag = indexPath.row
        cell.deleteButton.addTarget(self, action: #selector(updateFavorites(sender:)), for: .touchUpInside)

        return cell
    }
}

