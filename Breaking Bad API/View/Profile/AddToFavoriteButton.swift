//
//  AddToFavoriteButton.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 25.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit

class AddToFavoriteButton: UIButton {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setImage(UIImage(systemName: "heart"), for: .normal)
        
        imageView?.setDimensions(height: 27, width: 30)
        setDimensions(height: 27, width: 30)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func changeButtonImage(quoteInFavorites: Bool) {
        if quoteInFavorites {
            setImage(UIImage(systemName: "heart"), for: .normal)
            imageView?.tintColor = .systemBlue
        } else {
            setImage(UIImage(systemName: "heart.fill"), for: .normal)
            imageView?.tintColor = .systemRed
        }
    }

}
