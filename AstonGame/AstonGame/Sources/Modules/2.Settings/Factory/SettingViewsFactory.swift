//
//  SettingViewsFactory.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 26.03.2024.
//

import UIKit

enum SettingsViews {
    case user(delegate: UserDelegate?, player: Player?)
    case vehicle(delegate: VehicleDelegate?)
    case obstacles(delegate: ObstaclesDelegate?)
    case diffilty(delegate: DifficultyDelegate?)
}


private enum Titles {
    static var vehicles = "Vehicle settings"
    static var obstacles = "Choose obstacles"
    static var difficulty = "Set difficulty"
}

protocol SettingViewsFactory: AnyObject {
    func makeView(of type: SettingsViews) -> UIView
}

final class DefaultSettingsViewsFactory : SettingViewsFactory {
    func makeView(of type: SettingsViews) -> UIView {
        switch type {
            
        case let .user(delegate, player):
            let userView = makeUserView(delegate: delegate, player: player)
            return userView
            
        case let .vehicle(delegate):
            let vehicleCommonView = makeVehicleView(delegate: delegate, title: Titles.vehicles)
            return vehicleCommonView
            
        case let .obstacles(delegate):
            let obstaclesView = makeObstaclesView(delegate: delegate, title: Titles.obstacles)
            return obstaclesView
            
        case let .diffilty(delegate):
            let difficultyView = makeDifficultyView(delegate: delegate, title: Titles.difficulty)
            return difficultyView
            
        }
    }
    
}

extension DefaultSettingsViewsFactory {
    private func makeUserView(delegate: UserDelegate?, player: Player?) -> UserView {
        let userView = UserView()
        userView.delegate = delegate
        userView.configureWithLastPlayer(player: player)
        return userView
    }
    
    private func makeVehicleView(delegate: VehicleDelegate?, title: String) -> CommonView {
        let vehicleView = VehicleView()
        vehicleView.delegate = delegate
        let commonView = CommonView()
        commonView.setView(title: title, view: vehicleView)
        return commonView
    }
    
    private func makeObstaclesView(delegate: ObstaclesDelegate?, title: String) -> CommonView {
        let obstaclesView = ObstaclesView(selectables: ObstacleType.allCases, section: 0)
        obstaclesView.delegate = delegate
        let commonVIew = CommonView()
        commonVIew.setView(title: title, view: obstaclesView)
        return commonVIew
    }
    
    private func makeDifficultyView(delegate: DifficultyDelegate?, title: String) -> CommonView {
        let difficultyView = DifficultyView(selectables: Difficulty.allCases, section: 1)
        difficultyView.delegate = delegate
        let commonView = CommonView()
        commonView.separator.isHidden = true
        commonView.setView(title: title, view: difficultyView)
        return commonView
    }
}
