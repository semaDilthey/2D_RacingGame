//
//  AppCoordinator.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 06.03.2024.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    
    var childCoordinators : [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
        
    var window : UIWindow?
    private let controllerFactory: ControllerFactory = AppControllerFactory()
    
    init(navigationController : BaseNavController) {
        self.navigationController = navigationController
    }


    func start() {
        let mainViewController = controllerFactory.makeController(controller: .mainController, coordinator: self)
        navigationController = BaseNavController(rootViewController: mainViewController)
        if let window {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
    
    func navigateTo(controller: Controllers) {
        let controller = controllerFactory.makeController(controller: controller, coordinator: self)
        navigationController.pushViewController(controller, animated: true)
    }
}
