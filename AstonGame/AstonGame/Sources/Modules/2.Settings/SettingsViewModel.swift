//
//  SettingsViewModel.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 03.03.2024.
//

import Foundation
import UIKit

protocol VehicleSettings {
    func setVehicle(vehicle: String?)

}

protocol SettingsVMProtocol : BaseViewModelProtocol, VehicleSettings {
    func getGameData() -> GameData
    func getLastPlayer() -> Player?
    
    func setUser(name: String?, photo: PhotoStatus)
    func setDifficulty(difficulty: String?)
    func setObstacle(obstacle: String?)
    func removeObstacle(obstacle: String?)
}

final class SettingsViewModel: BaseViewModel ,SettingsVMProtocol {
    
    private var gameData: GameData = GameData(player: C.Default.player, settings: C.Default.settings)
    
    private var lastPlayer : Player?
    
    init(lastPlayer: Player?, coordinator: Coordinator?) {
        self.lastPlayer = lastPlayer
        super.init(coordinator: coordinator)
    }
    
    public func getGameData() -> GameData {
        return gameData
    }
    
    public func getLastPlayer() -> Player? {
        return lastPlayer
    }
    
    public func setUser(name: String? = nil, photo: PhotoStatus) {
        if let name {
            gameData.player.name = name
        }
        switch photo {
        case .some(let uIImage):
            gameData.player.photo = uIImage
        case .none:
            gameData.player.photo = nil
        }
    }
    
    public func setDifficulty(difficulty: String?) {
        if let difficulty {
            if let difficulty = Difficulty(rawValue: difficulty) {
                    gameData.settings.difficulty = difficulty
            }
        }
    }
    
    public func setVehicle(vehicle: String?) {
        if let vehicle {
            if let vehicle = VehicleType(rawValue: vehicle) {
                gameData.settings.vehicle = vehicle
            }
        }
    }
    
    public func setObstacle(obstacle: String?) {
        modifyObstacles { obstacles in
            guard let obstacle, let obstacleType = ObstacleType(rawValue: obstacle) else { return }
            obstacles.append(obstacleType)
        }
    }
    
    public func removeObstacle(obstacle: String?) {
        modifyObstacles { obstacles in
            guard let obstacle, let obstacleType = ObstacleType(rawValue: obstacle) else { return }
            obstacles.append(obstacleType)
            }
        }
        
    private func modifyObstacles(action: (inout [ObstacleType]) -> Void) {
        var obstacles = gameData.settings.obstacles ?? []
        action(&obstacles)
        if obstacles.isEmpty {
            gameData.settings.obstacles = nil
        } else {
            gameData.settings.obstacles = obstacles
        }
    }
}

extension SettingsViewModel {
    
}
