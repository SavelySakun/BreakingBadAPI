//
//  ProfileController.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 09.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit
import SDWebImage


class ProfileController: UITableViewController {
    
    // MARK: - Properties
    // Core Data properties
    let quotesCoreData = QuotesCoreData()
    let favoriteQuotesCoreData = FavoriteQuoteCoreData()
    
    // TableView properties
    var quotes = [Quote(id: -1, text: "Loading...", author: "...", isSavedToFavorites: nil, authorImg: "")]
    var quoteAPI = QuoteAPI()
    
    var selectedCharacter: Character = Character(id: 0, name: "Empty", birthday: "Empty", occupation: ["Empty"], img: "Empty", status: "Empty", nickname: "Empty", appearance: [0], portrayed: "Empty")
    
    // UI
    let headerView = ProfileHeader()
    
    // MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        quotesCoreData.delegate = self
        fetchDataToTableView(author: selectedCharacter.name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    // MARK: - Helpers
    func fetchDataToTableView(author: String) {
        if quotesCoreData.checkSavedQuotes(of: author) {
            quotesCoreData.retrieveQuotesFromCoreData(of: author)
        } else {
            quotesCoreData.getQuotesFromAPIAndSaveToCoreData(of: author)
        }
        tableView.reloadData()
    }
    
    func configureUI() {
        headerViewSetup()
        tableViewSetup()
    }
    
    func tableViewSetup() {
        title = "\(selectedCharacter.name)"
        tableView.sectionHeaderHeight = 45
        tableView.backgroundColor = .systemGray6
        tableView.register(ProfileQuoteCell.self, forCellReuseIdentifier: ProfileQuoteCell().cellReuseIdentifier)
    }
    
    func headerViewSetup() {
        
        tableView.tableHeaderView = headerView
        headerView.frame = .init(x: 0, y: 0, width: view.frame.width, height: 620)
        tableView.sectionHeaderHeight = 45
        
        headerView.nicknameLabel.text = selectedCharacter.nickname
        headerView.statusView.propertyLabel.text = selectedCharacter.status
        headerView.birthdayView.propertyLabel.text = selectedCharacter.birthday
        headerView.actorView.propertyLabel.text = selectedCharacter.portrayed
        headerView.ocupationView.propertyLabel.text = selectedCharacter.occupation[0]
        
        let imageURL = URL(string: selectedCharacter.img)
        let avatarImageView: UIImageView = {
            let iv = UIImageView()
            iv.sd_setImage(with: imageURL)
            return iv
        }()
        
        headerView.profileImageView.image = avatarImageView.image
    }
    
    
    // MARK: - Selectors
    @objc func updateFavorites(sender: UIButton) {
        
        let cellNumber = sender.tag
        let quote = quotes[cellNumber]
        let quoteId = quote.id
        let authorImg = selectedCharacter.img
        let quoteSavedStatus = quote.isSavedToFavorites
        
        favoriteQuotesCoreData.updateIsSavedToFavorites(quoteId: quoteId, authorImg: authorImg, currentFavoriteStatus: quoteSavedStatus!)
        
        if quotes[cellNumber].isSavedToFavorites! {
            quotes[cellNumber].isSavedToFavorites = false
        } else {
            quotes[cellNumber].isSavedToFavorites = true
        }
        tableView.reloadData()
    }
    
    // MARK: - TableView setup
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileQuoteCell().cellReuseIdentifier, for: indexPath) as! ProfileQuoteCell
        
        cell.selectionStyle = .none
        
        cell.contentView.isUserInteractionEnabled = false // You need to add it, otherwise the button in the cell will not work.
        
        let quote = quotes[indexPath.row]
        if quote.id == -1 {
            cell.addToFavoriteButton.isHidden = true
        } else {
            cell.addToFavoriteButton.isHidden = false
        }
        
        if quote.isSavedToFavorites ?? false {
            cell.addToFavoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            cell.addToFavoriteButton.imageView?.tintColor = .systemRed
        } else {
            cell.addToFavoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            cell.addToFavoriteButton.imageView?.tintColor = .systemBlue
        }
        
        cell.addToFavoriteButton.tag = indexPath.row
        cell.quoteLabel.text = quotes[indexPath.row].text
        cell.addToFavoriteButton.addTarget(self, action: #selector(updateFavorites(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Quotes"
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textAlignment = .center
    }
}


extension ProfileController: QuotesCoreDataDelegate {
    func fetchQuotes(quotesFromCoreData: [Quote]) {
        
        DispatchQueue.main.async {
            self.quotes = quotesFromCoreData
            
            if self.quotes.count == 0 {
                self.quotes.append(Quote(id: -1, text: "Can't find any quote.", author: ""))
                self.tableView.reloadData()
            } else {
                self.tableView.reloadData()
            }
        }
    }
}
