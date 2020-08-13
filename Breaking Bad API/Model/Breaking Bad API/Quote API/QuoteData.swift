//
//  QuoteData.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 13.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import Foundation

typealias QuoteData = [QuoteElement]

struct QuoteElement: Codable {
    var quote_id: Int
    var quote: String
    var author: String
}

