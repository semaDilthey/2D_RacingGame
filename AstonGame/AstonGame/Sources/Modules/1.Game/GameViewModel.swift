//
//  GameViewModel.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 03.03.2024.
//

import Foundation
import UIKit

protocol GameCycle {
    var isGameOver: Bool { get set }
    func startGame(completion: (()->()))
    func stopGame(completion: (()->()))
}

protocol GameVMProtocol : BaseViewModelProtocol, GameCycle {
    var setNewScore : ((Int)->())? { get set }
    
    func getSpeed() -> Double
    func increaseScore()
    func getScore() -> Int
    func getVehicleImage() -> UIImage?
    func getObstacleImage() -> UIImage?
}

final class GameViewModel : BaseViewModel, GameVMProtocol {
    
    private var gameData: GameData
    private var dataStorage: Persistable
    
    init(gameData: GameData, coordinator: Coordinator?, dataStorage: Persistable = DataStorage()) {
        self.gameData = gameData
        self.dataStorage = dataStorage
        super.init(coordinator: coordinator)
    }
    
    // Флажок, что игра закончилась. При отработке сохраняем результаты в кордату
    public var isGameOver: Bool = false {
        didSet {
            if isGameOver {
                savePlayer()
            }
        }
    }
    
    // Начинаем игру, в блоке делаем доп настройки для таймеров и анимаций
    public func startGame(completion: (()->())) {
        isGameOver = false
        completion()
    }

    // Останавливаем игру, срабатывается флажок
    public func stopGame(completion: (()->())) {
        if !isGameOver {
            isGameOver = true
            completion()
        }
    }
    
    // Устанавливаем новое значение для лейбла очков
    public var setNewScore : ((Int)->())?
    
    // Получаем скорость из настроек сложности, в зависимости от этого меняется скорость работы таймера
    public func getSpeed() -> Double {
        guard let difficulty = gameData.settings.difficulty else { return 4 }
        switch difficulty {
        case .easy:
            return 4
        case .medium:
            return 3
        case .hard:
            return 2
        }
    }
    
    // после прохожжения каждого объекта типа "Препятствие" плюсуем очки
    public func increaseScore() {
        scores += 1
    }
    
    // Возвращает набранные очки. Используется при отображении FinishView
    public func getScore() -> Int {
        scores
    }
    
    //возвращает картинку транспорта для конфигурации playerView
    public func getVehicleImage() -> UIImage? {
        gameData.settings.vehicle?.image
    }
    
    //возвращает картинку препятсвтия для конфигурации obstacleView
    public func getObstacleImage() -> UIImage? {
        gameData.settings.obstacles?.randomElement()?.image
    }
    
    // Отрабатывает при увеличении очков, просто обсервер
    private var scores = 0 {
        didSet {
            setNewScore?(scores)
        }
    }
}

private extension GameViewModel {
    
    // Обновляет в модели очки. После сохраняем обновленную модель в корДату
    func savePlayer() {
        gameData.player.score = scores
        dataStorage.savePlayer(gameData.player)
    }
    
}
