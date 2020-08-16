//
//  CharactersListViewController.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 07.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//
// Useful video about search controller - https://www.youtube.com/watch?v=P5ob4TXIK90

import UIKit
import SDWebImage

class CharactersController: UIViewController {
    
    // MARK: - Properties
    private let tableView = UITableView()
    var characters = [Character]()
    var characterAPI = CharacterAPI()
    
    // Properties for search
    var filteredCharacters = [Character]()
    lazy var searchController: UISearchController = {
        
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Character"
        searchController.searchBar.sizeToFit()
        searchController.searchBar.searchBarStyle = .default
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .black
            textField.backgroundColor = .white
        }
        return searchController
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
   
    
    // MARK: - Selectors
    
    // MARK: - Helpers
    func configureUI() {
        
        // Design setup.
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Characters"
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        fetchDataFromAPI()
        configureTableViewUI()
    }
    
    func fetchDataFromAPI() {
        tableView.isHidden = true // Hides table view while loads.
        showIndicator(description: nil) // Loading indicator shows.
        
        // Fetching data from API.
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
    
    func configureTableViewUI() {
        
        tableView.tableHeaderView = searchController.searchBar
        tableView.backgroundColor = .white
        tableView.frame = view.frame
        tableView.rowHeight = 80
        tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell().cellReuseIdentifier)
        
        // Shows separator only for existing cells.
        tableView.tableFooterView = UIView()
        
        // Table View Delegates.
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// Methods for search bar.
extension CharactersController {
    
    // Filtering values in tableView.
    func filterContentForSearchText(searchText: String) {
        filteredCharacters = characters.filter({ (character: Character) -> Bool in
            return character.name.lowercased().contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    // Helpers for search.
    func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && (!isSearchBarEmpty())
    }
}

// Table View Data Source.
extension CharactersController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() { return filteredCharacters.count }
        return characters.count
    }
    
    // Cells setup.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell().cellReuseIdentifier, for: indexPath) as! CharacterCell
        
        cell.accessoryType = .disclosureIndicator
        
        // Checks for filtering.
        let currentCharacter: Character
        if isFiltering() {
            currentCharacter = filteredCharacters[indexPath.row]
        } else {
            currentCharacter = characters[indexPath.row]
        }
        
        // Fetching data.
        let imageURL = URL(string: currentCharacter.img)
        cell.characterImageView.sd_setImage(with: imageURL)
        cell.nameLabel.text = currentCharacter.name
        cell.nicknameLabel.text = currentCharacter.nickname
        return cell
    }
}

// Configure search.
extension CharactersController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchText: searchBar.text!)
    }
}

// Confugure tap on row.
extension CharactersController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
                
        let vc = ProfileController()
        vc.selectedCharacter = characters[index]
        navigationController?.pushViewController(vc, animated: true)
    }
}

