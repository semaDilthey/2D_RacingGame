//
//  Player.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 16.02.2024.
//

import Foundation
import CoreData
import UIKit

protocol EntityModelMapProtocol {
    typealias EntityType = PlayerEntity
    /*
     mapToEntityInContext служит для преобразования модели Player в модель данных CoreData "EntityType" 
     */
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType
    /*
     mapFromEntity статичный метод, возвращает модель Player при внесении сущности EntityType
     */
    static func mapFromEntity(_ entity: EntityType) -> Player
}

struct Player {
    var name: String?
    var photo: UIImage?
    var score : Int?
}


extension Player : EntityModelMapProtocol {
    
    func mapToEntityInContext(_ context: NSManagedObjectContext) -> EntityType {
        let player = PlayerEntity(context: context)
        player.name = self.name
        player.image = self.photo?.jpegData(compressionQuality: 0.5)
        if let score = self.score {
            player.score = Int32(score)
        }
        return player
    }
    
    static func mapFromEntity(_ entity: EntityType) -> Player {
        let player = Player(name: entity.name ?? "No name",
                            photo: UIImage(data: entity.image ?? Data()) ?? UIImage(),
                            score: Int(entity.score))
        return player
    }
    
    
}
