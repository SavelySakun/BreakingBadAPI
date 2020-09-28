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
    
    let view = UIView()
    let profileImageView: ProfileImageView = {
        let iv = ProfileImageView()
        
        iv.image = UIImage(systemName: "person")
        iv.clipsToBounds = true
        iv.alignTop = true
        
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .systemGray4
        return iv
    }()
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    // Icons
    let statusView = CharacterProperty()
    let birthdayView = CharacterProperty()
    let ocupationView = CharacterProperty()
    var actorView = CharacterProperty()
    
    // Constraints
    var regularConstraints: [NSLayoutConstraint] = []
    var compactConstraints: [NSLayoutConstraint] = []
    var viewConstraints: [NSLayoutConstraint] = []
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI(traitCollection: traitCollection)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func configureUI(traitCollection: UITraitCollection) {
        
        configureIcons()
        
        let profileImageAndNameStack = UIStackView(arrangedSubviews: [profileImageView, nicknameLabel])
        let propertiesStack = UIStackView(arrangedSubviews: [statusView, birthdayView, ocupationView, actorView])
        
        profileImageAndNameStack.axis = .vertical
        propertiesStack.axis = .vertical
        
        view.translatesAutoresizingMaskIntoConstraints = false
        profileImageAndNameStack.translatesAutoresizingMaskIntoConstraints = false
        propertiesStack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(view)
        view.addSubview(profileImageAndNameStack)
        view.addSubview(propertiesStack)
        
        profileImageAndNameStack.spacing = 10
        propertiesStack.spacing = 10
        
        regularConstraints.append(contentsOf: [
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor),
            
            profileImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4),
            profileImageAndNameStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            profileImageAndNameStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageAndNameStack.bottomAnchor.constraint(equalTo: propertiesStack.topAnchor, constant: -20),
            
            propertiesStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30),
            propertiesStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30),
            propertiesStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate(regularConstraints)
    }
    
    
    func configureIcons() {
        birthdayView.iconImageView.image = #imageLiteral(resourceName: "birthday icon")
        actorView.iconImageView.image = #imageLiteral(resourceName: "actor icon")
        statusView.iconImageView.image = #imageLiteral(resourceName: "death icon")
        ocupationView.iconImageView.image = #imageLiteral(resourceName: "work icon")
    }
}
