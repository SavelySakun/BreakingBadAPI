//
//  SettingsCell.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 16.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {
    
    // MARK: - Properties
    let cellReuseIdentifier = "SettingCell"
    let settingLabel = UILabel()
    let settingSwitch = UISwitch()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(settingLabel)
        settingLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: 5, paddingLeft: 20, paddingBottom: 5)
        
        addSubview(settingSwitch)
        settingSwitch.centerY(inView: settingLabel)
        settingSwitch.anchor(right: rightAnchor, paddingRight: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
