//
//  CharacterData.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 07.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import Foundation

struct CharacterElement: Codable {
    var char_id: Int
    var name, birthday: String
    var occupation: [String]
    var img, status, nickname: String
    var appearance: [Int]
    var portrayed: String
    //var category: [String]
}

typealias CharacterData = [CharacterElement]
