//
//  Quote.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 13.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import Foundation

struct Quote {
    
	let id: Int
	let text: String
	let author: String
    var isSavedToFavorites: Bool?
    var authorImg: String?
}
