//
//  QuotesCoreData.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 25.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

// TODO: Добавить возвращение текста что "нет цитат", если апи не возвратило.

import UIKit
import CoreData

protocol QuotesCoreDataDelegate: class {
    func fetchQuotes(quotesFromCoreData: [Quote])
}

class QuotesCoreData {
    
    // MARK: - Properties
    var quotesCoreData: [NSManagedObject] = []
    var quotes = [Quote]()
    let quoteAPI = QuoteAPI()
    
    weak var delegate: QuotesCoreDataDelegate?
    
    // MARK: - Methods
    
    // 0. Helper method for Core Data.
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    // 1. Check is there any quotes already saved to Core Data.
    func checkSavedQuotes(of author: String) -> Bool {
        
        
        let managedContext = getContext()
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "QuoteCoreData")
        
        let predicate = NSPredicate(format: "author = %@", "\(author)")
        fetchRequest.predicate = predicate // Filter by selected author name.
        
        do {
            quotesCoreData = try managedContext.fetch(fetchRequest)
            
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        if quotesCoreData.count != 0 {
            return true
        } else {
            return false
        }
    }
    
    // 2. If not saved – load quotes from API and save to Core Data.
    func getQuotesFromAPIAndSaveToCoreData(of author: String) {
        
        quoteAPI.performRequest(author: author) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.saveQuotesToCoreData(quotesData: data, of: author)
                }
            case .failure(_):
                break
            }
        }
    }
    
    // 3. Saving quotes to Core Data.
    func saveQuotesToCoreData(quotesData: [Quote], of author: String) {
        
        let managedContext = getContext()
        let totalQuotes = quotesData.count
        for index in stride(from: 0, to: totalQuotes, by: 1) {
            
            let entity = NSEntityDescription.entity(forEntityName: "QuoteCoreData", in: managedContext)!
            let quote = NSManagedObject(entity: entity, insertInto: managedContext)
            let quoteData = quotesData[index]
                        
            quote.setValue(quoteData.id, forKey: "id")
            quote.setValue(quoteData.author, forKey: "author")
            quote.setValue(quoteData.text, forKey: "text")
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save: \(error.localizedDescription), \(error.userInfo)")
        }
        
        retrieveQuotesFromCoreData(of: author)
    }
    
    
    // 4. Retrieve quotes from Core Data.
    func retrieveQuotesFromCoreData(of author: String) {
        let managedContext = getContext()
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "QuoteCoreData")
        
        let predicate = NSPredicate(format: "author = %@", "\(author)")
        fetchRequest.predicate = predicate // Filter by selected author name.
        
        do {
            quotesCoreData = try managedContext.fetch(fetchRequest)
            let totalQuotes = quotesCoreData.count
                        
            for index in stride(from: 0, to: totalQuotes, by: 1) {
                let quote = quotesCoreData[index]
                quotes.append(Quote(
                    id: quote.value(forKey: "id") as! Int,
                    text: quote.value(forKey: "text") as! String,
                    author: quote.value(forKey: "author") as! String,
                    isSavedToFavorites: quote.value(forKey: "isSavedToFavorites") as? Bool,
                    authorImg: nil))
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        delegate?.fetchQuotes(quotesFromCoreData: quotes)
        quotes = [Quote]()
    }
    
}
