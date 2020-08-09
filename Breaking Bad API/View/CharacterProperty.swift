//
//  CharacterProperty.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 09.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit

class CharacterProperty: UIView {
    
    init(icon: UIImage? = #imageLiteral(resourceName: "actor icon"), property: String? = "Property") {
        super.init(frame: .zero)
        
        backgroundColor = .white
        layer.cornerRadius = 10
        //.setHeight(height: 40)
        
        let actorIconImageView: UIImageView = {
            let iv = UIImageView()
            iv.image = icon
            iv.setDimensions(height: 30, width: 30)
            return iv
        }()
        
        let actorLabel: UILabel = {
            let label = UILabel()
            label.text = property
            return label
        }()
        
        let stack = UIStackView(arrangedSubviews: [actorIconImageView, actorLabel])
        stack.axis = .horizontal
        stack.spacing = 15
        
        addSubview(stack)
        stack.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 15, paddingBottom: 15, paddingRight: 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
