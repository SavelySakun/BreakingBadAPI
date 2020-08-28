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
    
    let deleteButton: UIButton = {
        let b = UIButton()
        b.setDimensions(height: 24, width: 24)
        b.setImage(UIImage(systemName: "trash"), for: .normal)
        b.tintColor = .systemRed
        return b
    }()
    
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    
        addSubview(characterImageView)
        
        characterImageView.anchor(left: leftAnchor, paddingLeft: 20)
        characterImageView.setDimensions(height: 45, width: 45)
        characterImageView.layer.cornerRadius = 45 / 2
        
        
        let stack = UIStackView(arrangedSubviews: [nameLabel, quoteLabel])
        
        quoteLabel.numberOfLines = 0
        
        addSubview(stack)
        stack.axis = .vertical
        stack.spacing = 5
        stack.centerY(inView: characterImageView)
        stack.anchor(top: topAnchor, left: characterImageView.rightAnchor, bottom: bottomAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 15)
        
        addSubview(deleteButton)
        deleteButton.centerY(inView: stack)
        deleteButton.anchor(left: stack.rightAnchor, right: rightAnchor, paddingLeft: 15, paddingRight: 20)
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
