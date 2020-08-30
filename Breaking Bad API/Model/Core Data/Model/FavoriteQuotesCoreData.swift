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
    let quotesCoreData = QuotesCoreData()
    
    var quotes = [Quote]()
    var quotesArrayFromCoreData: [NSManagedObject] = []
    
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
            quotesArrayFromCoreData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        if currentFavoriteStatus {
            quotesArrayFromCoreData[0].setValue(false, forKey: "isSavedToFavorites")
        } else {
            quotesArrayFromCoreData[0].setValue(true, forKey: "isSavedToFavorites")
            quotesArrayFromCoreData[0].setValue(authorImg, forKey: "img")
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
            quotesArrayFromCoreData = try managedContext.fetch(fetchRequest)
            let totalQuotes = quotesArrayFromCoreData.count
            
            for index in stride(from: 0, to: totalQuotes, by: 1) {
                let quote = quotesArrayFromCoreData[index]
                
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

