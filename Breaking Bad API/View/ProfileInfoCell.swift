//
//  ProfileInfoCell.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 09.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit

class ProfileInfoCell: UITableViewCell {
    
    // MARK: - Properties
    let propertyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .systemGray
        return label
    }()

    
    let characterInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(propertyLabel)
        propertyLabel.setWidth(width: 120)
        propertyLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: 18, paddingLeft: 20, paddingBottom: 18)

        addSubview(characterInfoLabel)
        characterInfoLabel.centerY(inView: propertyLabel)
        characterInfoLabel.anchor(left: propertyLabel.rightAnchor, paddingLeft: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
  
