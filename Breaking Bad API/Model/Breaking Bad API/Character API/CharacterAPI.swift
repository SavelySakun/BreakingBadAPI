//
//  CharacterAPI.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 07.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import Foundation


class CharacterAPI {
    
    var characters = [Character]()
    var charactersData = CharacterData()
    
    func performRequest(completionHandler: @escaping (Result<[Character], Error>) -> Void)  {
        
        // TODO: Do something with force unwrapping. ->
        let url = URL(string: "https://breakingbadapi.com/api/characters/")!
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { data, response, error in
            
            let decoder = JSONDecoder()
            let decodedData = try! decoder.decode(CharacterData.self, from: data!)
            
            let data = decodedData
                        
            let totalCharacters = data.count - 1
            
            for index in stride(from: 0, to: totalCharacters, by: 1) {
                self.characters.append(Character(id: data[index].char_id, name: data[index].name, birthday: data[index].birthday, occupation: data[index].occupation, img: data[index].img, status: data[index].status, nickname: data[index].nickname, appearance: data[index].appearance, portrayed: data[index].portrayed))
            }
            
            completionHandler(.success(self.characters))
            
    }
        task.resume()
    }

}
