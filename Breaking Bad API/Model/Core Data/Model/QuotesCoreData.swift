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
    func fetchQuotes(quotesFromAPI: [Quote])
}

class QuotesCoreData {
    
    // MARK: - Properties
    var quotesCoreData: [NSManagedObject] = []
    var quotes = [Quote]()
    let quoteAPI = QuoteAPI()
    
    weak var delegate: QuotesCoreDataDelegate?
    
    // MARK: - Methods
    func retrieveQuotes(of author: String) {
        
        if checkSavedDataAndRetriveIfItsNotEmpty(author: author) {
            quoteAPI.performRequest(author: author) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self.saveQuotesFromAPIToCoreData(quotesData: data)
                        self.retrieveQuotesFromCoreData(of: author)
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
    
    func saveQuotesFromAPIToCoreData(quotesData: [Quote]) {
        print(#function)
        
        let managedContext = getContext()
        
        let totalQuotes = quotesData.count - 1
        
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
    }
    
    func retrieveQuotesFromCoreData(of author: String) {
        print(#function)
        let managedContext = getContext()
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "QuoteCoreData")
        
        let predicate = NSPredicate(format: "author = %@", "\(author)")
        fetchRequest.predicate = predicate // Filter by selected author name.
        
        do {
            quotesCoreData = try managedContext.fetch(fetchRequest)
            
            let totalQuotes = quotesCoreData.count - 1
            print("totalQuotes: \(totalQuotes)")
            
            for index in stride(from: 0, to: totalQuotes, by: 1) {
                
                let quote = quotesCoreData[index]
                
                quotes.append(Quote(
                    
                    id: quote.value(forKey: "id") as! Int,
                    text: quote.value(forKey: "text") as! String,
                    author: quote.value(forKey: "author") as! String,
                    isSavedToFavorites: quote.value(forKey: "isSavedToFavorites") as? Bool))
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        print("quotes from delegate: \(quotes)")
        delegate?.fetchQuotes(quotesFromAPI: quotes)
    }
    
    func checkSavedDataAndRetriveIfItsNotEmpty(author: String) -> Bool {
        
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
        
        if quotesCoreData.count == 0 {
            return true
        } else {
            retrieveQuotesFromCoreData(of: author)
            return false
        }
    }
    
    func updateIsSavedToFavorites(quoteId: Int, currentStatus: Bool) {
        let managedContext = getContext()
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "QuoteCoreData")
        
        let predicate = NSPredicate(format: "id = %@", "\(quoteId)")
        fetchRequest.predicate = predicate // Filter by selected quote text.
        
        do {
            quotesCoreData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        if currentStatus {
            quotesCoreData[0].setValue(false, forKey: "isSavedToFavorites")
        } else {
            quotesCoreData[0].setValue(true, forKey: "isSavedToFavorites")
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save: \(error.localizedDescription), \(error.userInfo)")
        }
        
    }
}