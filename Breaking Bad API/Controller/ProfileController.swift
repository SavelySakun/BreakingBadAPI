//
//  ProfileController.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 09.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit
import SDWebImage


class ProfileController: UITableViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    // Core Data properties
    let quotesCoreData = QuotesCoreData()
    
    var quotes = [Quote(id: 0, text: "Loading...", author: "...", isSavedToFavorites: false, authorImg: "")]
    var quoteAPI = QuoteAPI()
    let headerView = ProfileHeader()    
    var selectedCharacter: Character = Character(id: 0, name: "Empty", birthday: "Empty", occupation: ["Empty"], img: "Empty", status: "Empty", nickname: "Empty", appearance: [0], portrayed: "Empty")
    
    
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
    func fetchDataToTableView() {
        print(#function)
        
        quotesCoreData.retrieveQuotes(of: selectedCharacter.name) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.quotes = data
                    print("self.quotes from \(#function): \(self.quotes)")
                    if self.quotes.count == 0 {
                        self.quotes.append(Quote(id: -1, text: "Can't find any quote.", author: ""))
                        self.tableView.reloadData()
                    } else {
                        self.tableView.reloadData()
                    }
                }
            case .failure(_):
                break
            }
        }
    }
    
    func configureUI() {
        
        tableView.contentInsetAdjustmentBehavior = .never // TODO: Delete and fix tapbar bug.
        tableViewSetup()
    }
    
    func tableViewSetup() {
        tableView.backgroundColor = .systemGray6
        tableView.register(ProfileQuoteCell.self, forCellReuseIdentifier: ProfileQuoteCell().cellReuseIdentifier)
        
        headerViewSetup()
    }
    
    func headerViewSetup() {
        tableView.tableHeaderView = headerView
        headerView.frame = .init(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 1.2)
        tableView.sectionHeaderHeight = 45
        
        let imageURL = URL(string: selectedCharacter.img)
        
        headerView.nameLabel.text = selectedCharacter.name
        headerView.nicknameLabel.text = selectedCharacter.nickname
        headerView.statusView.propertyLabel.text = selectedCharacter.status
        headerView.birthdayView.propertyLabel.text = selectedCharacter.birthday
        headerView.actorView.propertyLabel.text = selectedCharacter.portrayed
        headerView.ocupationView.propertyLabel.text = selectedCharacter.occupation[0]
        
        let avatarImageView: UIImageView = {
            let iv = UIImageView()
            iv.sd_setImage(with: imageURL)
            return iv
        }()
        
        headerView.profileImageView.image = avatarImageView.image
    }
    
    // MARK: - Selectors
    @objc func addToFavorite(sender: UIButton) {
        
        let cellNumber = sender.tag
        
        // How to reach cell in tableView
        let indexPath = IndexPath(row: cellNumber, section: 0)
        let cell = tableView.cellForRow(at: indexPath) as! ProfileQuoteCell
        
        let quoteId = quotes[cellNumber].id
        let quoteSavedStatus = quotes[cellNumber].isSavedToFavorites
        
        let buttonStatus = cell.addToFavoriteButton.isSelected
        cell.addToFavoriteButton.changeButtonImage(buttonSelected: buttonStatus)
        
        quotesCoreData.updateIsSavedToFavorites(quoteId: quoteId, authorImg: selectedCharacter.img, currentFavoriteStatus: quoteSavedStatus!)
        
        if quoteSavedStatus! {
            quotes[cellNumber].isSavedToFavorites = false
        } else {
            quotes[cellNumber].isSavedToFavorites = true
        }
        
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
        
        if quotes[indexPath.row].isSavedToFavorites ?? false {
            cell.addToFavoriteButton.isSelected = true
            cell.addToFavoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .selected)
            cell.addToFavoriteButton.imageView?.tintColor = .systemRed
        }
        
        cell.addToFavoriteButton.tag = indexPath.row
        
        cell.quoteLabel.text = quotes[indexPath.row].text
        
        cell.addToFavoriteButton.addTarget(self, action: #selector(addToFavorite(sender:)), for: .touchUpInside)
        
        return cell
    }
    
}
