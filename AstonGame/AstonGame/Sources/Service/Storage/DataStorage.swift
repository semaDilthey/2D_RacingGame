//
//  DataStorage.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 22.02.2024.
//

import Foundation
import CoreData

protocol Persistable {
    mutating func savePlayer(_ player: Player)
    func getRecords() -> [Player]?
    func resetAll()
}

struct DataStorage : Persistable {
    
    private var players: [PlayerEntity] = []
    
    private let coreDataManager : CoreDataManager
    
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    
    //MARK: CRUD
    
    /// C
    // Сохраняем результат при завершении гонки в GameController
    mutating func savePlayer(_ player: Player) {
        let playerEntity = player.mapToEntityInContext(coreDataManager.context)
          
        do {
          try coreDataManager.context.save()
          self.players.append(playerEntity)
        } catch let error as NSError {
          print(error.localizedDescription)
        }
      }
        
    /// R
    // Получаем результаты при загрузке RecordsController
    /// Сортируем в порядке убывания через NSSortDescriptor
    func getRecords() -> [Player]? {
        var players : [Player]? = []
        
        let fetchRequest: NSFetchRequest<PlayerEntity> = PlayerEntity.fetchRequest()
        let sortDescriptorByScore = NSSortDescriptor(key: "score", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptorByScore]
        
        do {
            let playerEntities = try coreDataManager.context.fetch(fetchRequest)
            players = playerEntities.map { Player.mapFromEntity($0) }
        } catch {
            players = nil
        }
        return players
    }
    
    ///U
    // Если надо будет обновлять данные, то пусть будет метод для update
    func update(player: Player) {
        
    }
    
    /// D
    // Зануление corDat-ы
    func resetAll() {
        coreDataManager.resetAllCoreData()
    }
    
}
