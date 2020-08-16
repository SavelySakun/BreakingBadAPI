//
//  SettingsController.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 16.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
    
    // MARK: - Properties
    let tableView = UITableView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI() {
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        
        tableViewSetup()
    }
    
    func tableViewSetup() {
        tableView.frame = view.frame
        tableView.rowHeight = 50
        tableView.register(SettingCell.self, forCellReuseIdentifier: SettingCell().cellReuseIdentifier)
        tableView.dataSource = self
    }
    
}

extension SettingsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell().cellReuseIdentifier, for: indexPath) as! SettingCell
        
        cell.settingLabel.text = "Breaking Bad color theme"
        
        return cell
    }
    
}
