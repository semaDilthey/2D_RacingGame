//
//  ControllerFactory.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 06.03.2024.
//

import Foundation
import UIKit

enum Controllers {
    case mainController
    case gameController(gameData: GameData)
    case settingsController(output: SettingsOutput, lastPlayer: Player?)
    case recordsController
}

protocol ControllerFactory : AnyObject {
    /* Фабрика имеет один метод, но может расширяться в зависимости от контроллеров в енаме */
    func makeController(controller: Controllers, coordinator: Coordinator) -> UIViewController
}


class AppControllerFactory : ControllerFactory {
        
    func makeController(controller: Controllers, coordinator: Coordinator) -> UIViewController {
        
        switch controller {
            
        case .mainController:
            let mainVM = MainViewModel(coordinator: coordinator)
            let mainVC = MainController(viewModel: mainVM)
            return mainVC
            
        case .gameController(let gameData):
            let gameVM = GameViewModel(gameData: gameData, coordinator: coordinator)
            let gameVC = GameController(viewModel: gameVM)
            return gameVC
            
        case let .settingsController(output, lastPlayer):
            let settingsVM = SettingsViewModel(lastPlayer: lastPlayer, coordinator: coordinator)
            let settingsVC = SettingsController(viewModel: settingsVM)
            settingsVC.output = output
            return settingsVC
            
        case .recordsController:
            let recordsVM = RecordsViewModel(coordinator: coordinator)
            let recordsVC = RecordsController(viewModel: recordsVM)
            return recordsVC
        }
    }
    
}
