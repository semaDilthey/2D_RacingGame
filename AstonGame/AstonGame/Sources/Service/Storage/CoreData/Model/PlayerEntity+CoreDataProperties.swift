//
//  PlayerEntity+CoreDataProperties.swift
//  
//
//  Created by Семен Гайдамакин on 03.03.2024.
//
//

import Foundation
import CoreData

@objc(PlayerEntity)
public class PlayerEntity: NSManagedObject {}

extension PlayerEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerEntity> {
        return NSFetchRequest<PlayerEntity>(entityName: "PlayerEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var image: Data?
    @NSManaged public var score: Int32

}
