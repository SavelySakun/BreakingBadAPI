//
//  QuoteCoreData+CoreDataProperties.swift
//  Breaking Bad API
//
//  Created by Савелий Сакун on 25.08.2020.
//  Copyright © 2020 Savely Sakun. All rights reserved.
//
//

import Foundation
import CoreData


extension QuoteCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuoteCoreData> {
        return NSFetchRequest<QuoteCoreData>(entityName: "QuoteCoreData")
    }

    @NSManaged public var author: String?
    @NSManaged public var id: Int64
    @NSManaged public var text: String?

}
