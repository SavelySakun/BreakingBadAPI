//
//  QuoteDataCoreData+CoreDataProperties.swift
//  
//
//  Created by Савелий Сакун on 21.08.2020.
//
//

import Foundation
import CoreData


extension QuoteDataCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuoteDataCoreData> {
        return NSFetchRequest<QuoteDataCoreData>(entityName: "QuoteDataCoreData")
    }

    @NSManaged public var author: String?
    @NSManaged public var quote: String?
    @NSManaged public var quoteId: Int64

}
