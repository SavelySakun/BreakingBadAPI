//
//  QuotesCoreData.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 25.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit
import CoreData

class QuotesCoreData {
    
    // MARK: - Properties
    var quotesCoreData: [NSManagedObject] = []
    var quotes = [Quote]()
    
    // MARK: - Methods
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func save(selectedQuote: Quote) {
        
        let managedContext = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "QuoteCoreData", in: managedContext)!
        let quote = NSManagedObject(entity: entity, insertInto: managedContext)
        
        quote.setValue(selectedQuote.text, forKey: "text")
        quote.setValue(selectedQuote.author, forKey: "author")
        quote.setValue(selectedQuote.id, forKey: "id")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save: \(error.localizedDescription), \(error.userInfo)")
        }
    }
    
    func delete(selectedQuote: Quote) {
        
    }
    
    func loadQuotes() {
        
    }
}
