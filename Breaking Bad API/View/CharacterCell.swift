//
//  CharacterCell.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 07.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell {
    
    // MARK: - Properties
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let characterImageView: UIImageView = {
        let iv = UIImageView()
        
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        
        return iv
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(characterImageView)
        characterImageView.anchor(left: leftAnchor, paddingLeft: 10)
        characterImageView.setDimensions(height: 40, width: 40)
        characterImageView.layer.cornerRadius = 40 / 2
        characterImageView.centerY(inView: self)
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, nicknameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.anchor(left: characterImageView.rightAnchor, right: rightAnchor, paddingLeft: 12, paddingRight: 12)
        stack.centerY(inView: characterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
