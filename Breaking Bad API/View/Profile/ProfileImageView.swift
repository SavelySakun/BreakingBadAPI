//
//  ProfileImageView.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 27.09.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit
import UIImageViewAlignedSwift

class ProfileImageView: UIImageViewAligned {

    override func layoutSubviews() {
        super.layoutSubviews()

        let constraint: NSLayoutConstraint = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1.0, constant: 0.0); self.addConstraint(constraint)
        
        let radius: CGFloat = self.bounds.size.width / 2.0

        self.layer.cornerRadius = radius
    }
}
