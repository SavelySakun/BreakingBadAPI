//
//  CharacterCoreData+CoreDataProperties.swift
//  
//
//  Created by Савелий Сакун on 21.08.2020.
//
//

import Foundation
import CoreData


extension CharacterCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterCoreData> {
        return NSFetchRequest<CharacterCoreData>(entityName: "CharacterCoreData")
    }

    @NSManaged public var appearance: [Int]?
    @NSManaged public var birthday: String?
    @NSManaged public var id: Int64
    @NSManaged public var img: String?
    @NSManaged public var name: String?
    @NSManaged public var nickname: String?
    @NSManaged public var occupation: [String]?
    @NSManaged public var portrayed: String?
    @NSManaged public var status: String?

}
