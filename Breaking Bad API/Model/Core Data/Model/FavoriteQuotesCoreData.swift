//
//  FavoriteQuotesCoreData.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 28.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//

import UIKit
import CoreData

class FavoriteQuoteCoreData {
    
    // MARK: - Properties
    var quotes = [Quote]()
    var quotesCoreData: [NSManagedObject] = []
    
    let quotesCD = QuotesCoreData()
    
    // MARK: - Methods
    
    // 0. Helper method for Core Data.
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func updateIsSavedToFavorites(quoteId: Int, authorImg: String, currentFavoriteStatus: Bool) {

        let managedContext = getContext()
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "QuoteCoreData")
        
        let predicate = NSPredicate(format: "id = %@", "\(quoteId)")
                
        fetchRequest.predicate = predicate // Filter by selected quote id.
        
        do {
            quotesCoreData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        if currentFavoriteStatus {
            quotesCoreData[0].setValue(false, forKey: "isSavedToFavorites")
        } else {
            quotesCoreData[0].setValue(true, forKey: "isSavedToFavorites")
            quotesCoreData[0].setValue(authorImg, forKey: "img")
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save: \(error.localizedDescription), \(error.userInfo)")
        }
        
        
    }
    
    func retrieveFavoritesQuotes(completionHandler: @escaping (Result<[Quote], Error>) -> Void) {
        let managedContext = getContext()
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "QuoteCoreData")
        
        let predicate = NSPredicate(format: "isSavedToFavorites == YES")
        fetchRequest.predicate = predicate // Filter by saved to favorites.
        
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
                    authorImg: quote.value(forKey: "img") as? String))
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        completionHandler(.success(self.quotes))
        quotes = [Quote]()
    }
    
    
}

