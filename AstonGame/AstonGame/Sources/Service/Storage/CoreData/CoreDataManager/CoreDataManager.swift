//
//  CoreDataManager.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 03.03.2024.
//

import Foundation
import CoreData
import UIKit

enum PersistenceError: Error {
    case managedObjectContextNotFound
    case couldNotSaveObject
    case objectNotFound
    case couldNotDeleteObject
    case error(Error)
    
    var localizedDescription: String {
        switch self {
        case .managedObjectContextNotFound:
            "Не удалось найти контекст"
        case .couldNotSaveObject:
            "Не удалось сохранить объект"
        case .objectNotFound:
            "Объект не найден"
        case .couldNotDeleteObject:
            "Не удалось удалить объект"
        case .error(let error):
            error.localizedDescription
        }
    }
}

final class CoreDataManager : NSObject {
    
    public static let shared = CoreDataManager()

    private override init() { }

    private var appDelegate : AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }

    var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }

    var persistentContainer : NSPersistentContainer {
        appDelegate.persistentContainer
    }

    func saveContext() {
        appDelegate.saveContext()
    }

    func resetAllCoreData() {
        let entityNames = self.persistentContainer.managedObjectModel.entities.map({ $0.name!})
        entityNames.forEach { [weak self] entityName in
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            
            do {
                try self?.context.execute(deleteRequest)
                try self?.context.save()
            } catch {
                PersistenceError.couldNotDeleteObject.localizedDescription
            }
        }
    }
}

