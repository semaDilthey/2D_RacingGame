//
//  Coordinator.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 06.03.2024.
//

import Foundation
import UIKit

protocol Coordinator : AnyObject {
    var childCoordinators : [Coordinator] { get set }
    var parentCoordinator : Coordinator? { get set }
    var navigationController : UINavigationController { get set }
    
    func start()
    func navigateTo(controller: Controllers)
}

extension Coordinator {
    
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
    
}
