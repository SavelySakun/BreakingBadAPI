//
//  CharacterProfile.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 09.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit
import UIImageViewAlignedSwift

public class ProfileHeader: UIView {
    
    // MARK: - Properties
    let view: UIView = {
        let v = UIView()
        v.backgroundColor = .systemGray6
        return v
    }()
    
    let profileImageView: UIImageViewAligned = {
        let iv = UIImageViewAligned()
        
        iv.image = UIImage(systemName: "person")
        iv.layer.cornerRadius = 200 / 2
        iv.clipsToBounds = true
        iv.alignTop = true
        
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .systemGray4
        return iv
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        return label
    }()
    
    // Icons
    let statusView = CharacterProperty()
    let birthdayView = CharacterProperty()
    let ocupationView = CharacterProperty()
    var actorView = CharacterProperty()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configureUI() {
                
        configureIcons()
        
        addSubview(view)
        view.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0)
                
        view.addSubview(profileImageView)
        profileImageView.setHeight(height: 200)
        profileImageView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 100, paddingRight: 100)
        
        let propertiesStack = UIStackView(arrangedSubviews: [statusView, birthdayView, ocupationView, actorView])
        view.addSubview(propertiesStack)
        
        view.addSubview(nicknameLabel)
        nicknameLabel.centerX(inView: profileImageView)
        
        propertiesStack.axis = .vertical
        propertiesStack.spacing = 7
        
        propertiesStack.anchor(top: nicknameLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 60, paddingBottom: 40, paddingRight: 60)
    }
    
    func configureIcons() {
        birthdayView.iconImageView.image = #imageLiteral(resourceName: "birthday icon")
        actorView.iconImageView.image = #imageLiteral(resourceName: "actor icon")
        statusView.iconImageView.image = #imageLiteral(resourceName: "death icon")
        ocupationView.iconImageView.image = #imageLiteral(resourceName: "work icon")
    }
}
