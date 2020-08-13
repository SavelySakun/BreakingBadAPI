//
//  ProfileQuotes.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 09.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit

class ProfileQuoteCell: UITableViewCell {
    
    // MARK: - Properties
    let cellReuseIdentifier = "ProfileQuoteCell"
    
    let quoteLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    let view: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        return v
    }()
    
    let favoriteIcon: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage.init(systemName: "star")
        iv.setDimensions(height: 22, width: 24)
        return iv
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(quoteLabel)
        addSubview(favoriteIcon)
        
        quoteLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: favoriteIcon.leftAnchor, paddingTop: 25, paddingLeft: 20, paddingBottom: 25, paddingRight: 20)
        
        
        favoriteIcon.centerY(inView: quoteLabel)
        favoriteIcon.anchor(right: rightAnchor, paddingRight: 25)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
}
