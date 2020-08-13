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
    var quotes = [Quote(quoteId: 1, quote: "Loading...", author: "WW")]
    var quoteAPI = QuoteAPI()
    let headerView = ProfileHeader()    
    var selectedCharacter: Character = Character(id: 0, name: "Empty", birthday: "Empty", occupation: ["Empty"], img: "Empty", status: "Empty", nickname: "Empty", appearance: [0], portrayed: "Empty")
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        quoteAPI.delegate = self
        self.quoteAPI.performRequest(author: self.selectedCharacter.name)
        
        
                        
        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI() {

        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add to Favorites", style: .done, target: self, action: #selector(addCharacterToFavorites))
        
        tableViewSetup()
    }
    
    func tableViewSetup() {
        tableView.backgroundColor = .systemGray6
        tableView.register(ProfileQuoteCell.self, forCellReuseIdentifier: ProfileQuoteCell().cellReuseIdentifier)
        
        headerViewSetup()
    }
    
    func headerViewSetup() {
        tableView.tableHeaderView = headerView
        headerView.frame = .init(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 1.4)
        tableView.sectionHeaderHeight = 45
        
        let imageURL = URL(string: selectedCharacter.img)
        
        headerView.nameLabel.text = selectedCharacter.name
        headerView.nicknameLabel.text = selectedCharacter.nickname
        
        headerView.statusView.propertyLabel.text = selectedCharacter.status
        headerView.statusView.iconImageView.image = #imageLiteral(resourceName: "Death icon")
        headerView.birthdayView.propertyLabel.text = selectedCharacter.birthday
        headerView.actorView.propertyLabel.text = selectedCharacter.portrayed
        headerView.actorView.iconImageView.image = #imageLiteral(resourceName: "Actor icon")
        headerView.ocupationView.propertyLabel.text = selectedCharacter.occupation[0]
        headerView.ocupationView.iconImageView.image = #imageLiteral(resourceName: "Work icon")
        
        let avatarImageView: UIImageView = {
            let iv = UIImageView()
            iv.sd_setImage(with: imageURL)
            return iv
        }()
        
        headerView.profileImageView.image = avatarImageView.image
    }
    
    // MARK: - Selectors
    @objc func addCharacterToFavorites() {
        let controller = ProfileHeader()
        
        
        tableView.tableHeaderView = controller
        controller.frame = .init(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 1.4)
        
        tableView.reloadData()
    }
}

// MARK: - TableView Setup
extension ProfileController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Popular quotes"
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textAlignment = .center
    }
    
    // Quotes table view cells.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileQuoteCell().cellReuseIdentifier, for: indexPath) as! ProfileQuoteCell
        
        cell.quoteLabel.text = quotes[indexPath.row].quote
        
        return cell
    }
    
}

extension ProfileController: QuoteAPIDelegate {
    func fetchQuotes(quotesArray: [Quote]) {
        DispatchQueue.main.async {
            self.quotes = quotesArray
            self.tableView.reloadData()
        }
    }
    
    
}
