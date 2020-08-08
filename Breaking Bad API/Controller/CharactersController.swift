//
//  CharactersListViewController.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 07.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit

class CharactersController: UIViewController {
    
    // MARK: - Properties
    private let tableView = UITableView()
    
    var characters = [Character(id: 1, name: "Loading", birthday: "Test", occupation: ["Test"], img: "Test", status: "Test", nickname: "Please wait a second...", appearance: [1], portrayed: "Test")]
    
    var characterAPI = CharacterAPI()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        characterAPI.performRequest() { result in
            switch result {
            case .success(let data):
                self.characters = data // Передаю дату по персонажам из API.
                //print(self.characters)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(_):
                break
            }
        }
        
    }
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    func configureUI() {
        view.backgroundColor = .white
        configureTableView()
    }
    
    func configureTableView() {
        
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
        
        cell.nameLabel.text = characters[indexPath.row].name
        cell.nicknameLabel.text = characters[indexPath.row].nickname
        cell.characterImageView.image = #imageLiteral(resourceName: "testIMG")
        
        return cell
    }
}


