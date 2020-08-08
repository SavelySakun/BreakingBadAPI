//
//  CharactersListViewController.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 07.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit
import SDWebImage

class CharactersController: UIViewController {
    
    // MARK: - Properties
    private let tableView = UITableView()
    var characters = [Character]()
    var characterAPI = CharacterAPI()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDataFromAPI()
        configureUI()
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    fileprivate func fetchDataFromAPI() {
        
        tableView.isHidden = true
        showIndicator(description: nil)
        
        characterAPI.performRequest() { result in
            switch result {
            case .success(let data):
                self.characters = data // Передаю дату по персонажам из API.
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView.isHidden = false
                    self.dismissIndicator()
                }
            case .failure(_):
                break
            }
        }
    }
    
    func configureUI() {
        view.backgroundColor = .white
        configureTableViewUI()

    }
    
    func configureTableViewUI() {
        // Design setup.
        tableView.backgroundColor = .white
        view.addSubview(tableView)
        tableView.frame = view.frame
        tableView.rowHeight = 80
        tableView.register(CharacterCell.self, forCellReuseIdentifier: K.cells.characterCell)
        
        // Shows separator only for existing cells.
        tableView.tableFooterView = UIView()
        
        // Table View Delegates.
        //tableView.delegate = self
        tableView.dataSource = self
    }
}

// Table View Data Source.

extension CharactersController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cells.characterCell, for: indexPath) as! CharacterCell
        
        cell.accessoryType = .disclosureIndicator
        
        let imageURL = URL(string: characters[indexPath.row].img)
        cell.characterImageView.sd_setImage(with: imageURL)
        cell.nameLabel.text = characters[indexPath.row].name
        cell.nicknameLabel.text = characters[indexPath.row].nickname
        
        return cell
    }
}


