//
//  ProfileController.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 09.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit

class ProfileController: UITableViewController {
    
    
    // MARK: - Properties
    private let reuseIdentifier = "ProfileInfoCell"
    
    let headerView = ProfileHeader()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        tableViewSetup()
    }
    
    // MARK: - Selectors
    func tableViewSetup() {
        
        tableView.register(ProfileInfoCell.self, forCellReuseIdentifier: reuseIdentifier)
        
    }
    
    func configureUI() {
        
        tableView.tableHeaderView = headerView
        headerView.frame = .init(x: 0, y: 0, width: view.frame.width, height: view.frame.height / 1.4)
        
        
        headerView.profileImageView.image = #imageLiteral(resourceName: "testIMG")
    }
    
    // MARK: - Helpers
    
    
    
}

// MARK: - TableView Setup
extension ProfileController {

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProfileInfoCell
        
        switch indexPath.row {
        case 0:
            
            cell.propertyLabel.text = "Name:"
            cell.characterInfoLabel.text = "Walter White"
        case 1:
            cell.propertyLabel.text = "Birthday:"
            cell.characterInfoLabel.text = "09-07-1958"
        case 2:
            cell.propertyLabel.text = "Nickname:"
            cell.characterInfoLabel.text = "Heisenberg"
        case 3:
            cell.propertyLabel.text = "Nickname:"
            cell.characterInfoLabel.text = "Heisenberg"
        default:
            cell.textLabel!.text = "–"
        }
        
        return cell
    }
    
}
