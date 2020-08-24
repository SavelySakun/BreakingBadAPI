//
//  CharacterCell.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 07.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit
import UIImageViewAlignedSwift

class CharacterCell: UITableViewCell {
    
    // MARK: - Properties
    let cellReuseIdentifier = "CharacterCell"
    
    let characterImageView: UIImageViewAligned = {
        let iv = UIImageViewAligned()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .systemGray6
        iv.alignTop = true
        
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(characterImageView)
        characterImageView.anchor(left: leftAnchor, paddingLeft: 15)
        characterImageView.setDimensions(height: 55, width: 55)
        characterImageView.layer.cornerRadius = 55 / 2
        characterImageView.centerY(inView: self)
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, nicknameLabel])
        stack.axis = .vertical
        stack.spacing = 4
        
        addSubview(stack)
        stack.anchor(left: characterImageView.rightAnchor, right: rightAnchor, paddingLeft: 15, paddingRight: 12)
        stack.centerY(inView: characterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
