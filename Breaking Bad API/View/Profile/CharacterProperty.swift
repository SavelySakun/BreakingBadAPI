//
//  CharacterProperty.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 09.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit

class CharacterProperty: UIView {
    
    var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "testIMG")
        iv.setDimensions(height: 30, width: 30)
        return iv
    }()
    
    var propertyLabel: UILabel = {
        let label = UILabel()
        label.text = "Property"
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .white
        layer.cornerRadius = 10

        let stack = UIStackView(arrangedSubviews: [iconImageView, propertyLabel])
        stack.axis = .horizontal
        stack.spacing = 15
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 15, paddingRight: 15)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
