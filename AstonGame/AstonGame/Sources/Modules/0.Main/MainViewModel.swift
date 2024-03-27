//
//  MainViewModel.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 03.03.2024.
//

import Foundation
import UIKit

protocol MainVMProtocol: BaseViewModelProtocol {
    func setGameData(gameData: GameData)
    
    func startGame(controller: UIViewController & SettingsOutput)
    func presentSettingsController(output: SettingsOutput)
    func presentRecordsController()
}

final class MainViewModel: BaseViewModel, MainVMProtocol {
    
    private var gameData : GameData?
    private var dataStorage : Persistable
    
    init(coordinator: Coordinator?, dataStorage : Persistable = DataStorage()) {
        self.dataStorage = dataStorage
        super.init(coordinator: coordinator)
    }
    
    private var isFirstStart : Bool = true
    
    // Используется в методе делегата при SettingsOutput
    func setGameData(gameData: GameData) {
        self.gameData = gameData
    }
    
    //MARK: - Navigation

    func startGame(controller: UIViewController & SettingsOutput) {
        // Метод запускающий игру в зависимости от 3 разных сценариев
        getLastPlayer { [weak self] player in
            /// Асинхронно получаем последнего игрока
            guard let self else { return }
            if player == nil && self.gameData == nil {
                self.firstEnterStart(player: player, controller: controller)
            }
        
            else if self.isFirstStart {
                self.firstStartWhenPlayerExists(player: player, controller: controller)
            }

            else {
                startWhenIsPlaying(player: player, controller: controller)
            }
        }
    }
    
    func presentSettingsController(output: SettingsOutput) {
        getLastPlayer { [weak self] player in
            if let player = player {
                self?.coordinator?.navigateTo(controller: .settingsController(output: output, lastPlayer: player))
            } else {
                self?.coordinator?.navigateTo(controller: .settingsController(output: output, lastPlayer: nil))
            }
        }
        
    }
    
    func presentRecordsController() {
        coordinator?.navigateTo(controller: .recordsController)
    }
}

extension MainViewModel {
    
    private func firstEnterStart(player: Player?, controller: UIViewController & SettingsOutput) {
        print("Case 1")
        // Кейс 1: Игрок зашел впервые ИЛИ нет никаких данных о его прошлых играх
        self.isFirstStart = false
        self.showNoPlayerAlert(controller: controller)
    }
    
    private func firstStartWhenPlayerExists(player: Player?, controller: UIViewController & SettingsOutput) {
        print("Case 2")
        // Кейс 2: Игрок только зашел в игру, но уже играл и есть прогресс его прошлых игр.
        // Тогда в рекорды пойдет запись для этого игрока
        guard let lastPlayer = player else {
            print("No player found")
            return
        }
        if let gameData = self.gameData {
            self.openGameController(gameData: gameData)
        } else {
            let gameData = GameData(player: lastPlayer, settings: C.Default.settings)
            self.setGameData(gameData: gameData)
            self.openGameController(gameData: gameData)
        }
    }
    
    private func startWhenIsPlaying(player: Player?, controller: UIViewController & SettingsOutput) {
        print("Case 3")
        // Кейс 3: Игрок уже играет и это его не первая игра в этой сессии.
        // Тогда настройки в сессии сохраняются
        if let gameData = self.gameData {
            self.openGameController(gameData: gameData)
        }
    }
    
}

extension MainViewModel {
    
    private func openGameController(gameData: GameData) {
        coordinator?.navigateTo(controller: .gameController(gameData: gameData))
    }
    
    private enum AlertCase {
        static let title = "No player found"
        static let message = "Enter settings and create a player"
        static let createAction = "Create player"
        static let cancelAction = "Cancel"
    }
    
    private func showNoPlayerAlert(controller: UIViewController&SettingsOutput) {
        let alert = UIAlertController(title: AlertCase.title, message: nil) {
            self.presentSettingsController(output: controller)
        }
        controller.present(alert, animated: true)
    }
    
    
    private func getLastPlayer(completion: @escaping (Player?) -> Void) {
        print(#function)
        DispatchQueue.main.async {
            let lastPlayer = self.dataStorage.getRecords()?.last
            completion(lastPlayer)
        }
    }
    
}
