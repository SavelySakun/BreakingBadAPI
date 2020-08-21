//
//  QuoteDataCoreData+CoreDataProperties.swift
//  
//
//  Created by Савелий Сакун on 21.08.2020.
//
//

import Foundation
import CoreData


extension QuoteCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuoteCoreData> {
        return NSFetchRequest<QuoteCoreData>(entityName: "QuoteDataCoreData")
    }

    @NSManaged public var author: String?
    @NSManaged public var quote: String?
    @NSManaged public var quoteId: Int64

}
