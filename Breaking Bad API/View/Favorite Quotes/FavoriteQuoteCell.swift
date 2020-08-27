//
//  FavoriteQuoteCell.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 17.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit
import UIImageViewAlignedSwift

class FavoriteQuoteCell: UITableViewCell {
    
    // MARK: - Properties
    let cellReuseIdentifier = "FavoriteQuoteCell"
    
    let quoteLabel = UILabel()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    let characterImageView: UIImageViewAligned = {
        let iv = UIImageViewAligned()
        
        iv.clipsToBounds = true
        iv.alignTop = true
        
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .systemGray5
        return iv
    }()
    
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    
        addSubview(characterImageView)
        
        characterImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 20)
        characterImageView.setDimensions(height: 45, width: 45)
        characterImageView.layer.cornerRadius = 45 / 2
        
        addSubview(nameLabel)
        nameLabel.anchor(top: topAnchor, left: characterImageView.rightAnchor, paddingTop: 10, paddingLeft: 10)
        
        addSubview(quoteLabel)
        quoteLabel.numberOfLines = 0
        quoteLabel.anchor(top: nameLabel.bottomAnchor, left: characterImageView.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 10, paddingRight: 15)
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
