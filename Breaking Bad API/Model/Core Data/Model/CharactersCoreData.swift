//
//  CoreData.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 21.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit
import CoreData

protocol CharactersCoreDataDelegate: class {
    func fetchCharacters(charactersFromCoreData: [Character])
}

class CharactersCoreData {
    
    // MARK: - Properties
    var charactersCoreData: [NSManagedObject] = []
    var characters = [Character]()
    let characterAPI = CharacterAPI()
    
    weak var delegate: CharactersCoreDataDelegate?
    
    // MARK: - Methods
    func retrieveCharacters() {
        
        
        if checkSavedDataAndRetriveIfItsNotEmpty() {
            characterAPI.performRequest { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.saveCoreData(charactersData: data)
                        self.retrieveFromCoreData()
                    }
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveCoreData(charactersData: [Character]) {
        
        let managedContext = getContext()
        
        // Sets values of characters into NSManagedObject
        let totalCharacters = charactersData.count - 1
        
        for index in stride(from: 0, to: totalCharacters, by: 1) {
            
            let entity = NSEntityDescription.entity(forEntityName: "CharacterCoreData", in: managedContext)!
            let character = NSManagedObject(entity: entity, insertInto: managedContext)
            let charData = charactersData[index]
            
            character.setValue(charData.id, forKeyPath: "id")
            character.setValue(charData.name, forKeyPath: "name")
            character.setValue(charData.birthday, forKeyPath: "birthday")
            character.setValue(charData.occupation, forKeyPath: "occupation")
            character.setValue(charData.img, forKeyPath: "img")
            character.setValue(charData.status, forKeyPath: "status")
            character.setValue(charData.nickname, forKeyPath: "nickname")
            character.setValue(charData.appearance, forKeyPath: "appearance")
            character.setValue(charData.portrayed, forKeyPath: "portrayed")
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save: \(error.localizedDescription), \(error.userInfo)")
        }
    }
    
    func retrieveFromCoreData() {
        
        let managedContext = getContext()
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "CharacterCoreData")
        
        do {
            charactersCoreData = try managedContext.fetch(fetchRequest)
            
            let totalCharacters = charactersCoreData.count - 1
            
            for index in stride(from: 0, to: totalCharacters, by: 1) {
                
                let character = charactersCoreData[index]
                characters.append(Character(
                    
                    id: character.value(forKey: "id") as! Int,
                    name: character.value(forKey: "name") as! String,
                    birthday: character.value(forKey: "birthday") as! String,
                    occupation: character.value(forKey: "occupation") as! [String],
                    img: character.value(forKey: "img") as! String,
                    status: character.value(forKey: "status") as! String,
                    nickname: character.value(forKey: "nickname") as! String,
                    appearance: character.value(forKey: "appearance") as! [Int],
                    portrayed: character.value(forKey: "portrayed") as! String))
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        delegate?.fetchCharacters(charactersFromCoreData: characters)
    }
    
    func checkSavedDataAndRetriveIfItsNotEmpty() -> Bool {
        
        let managedContext = getContext()
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "CharacterCoreData")
        
        do {
            charactersCoreData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        if charactersCoreData.count == 0 {
            return true
        } else {
            retrieveFromCoreData()
           return false
        }
    }
    
}
