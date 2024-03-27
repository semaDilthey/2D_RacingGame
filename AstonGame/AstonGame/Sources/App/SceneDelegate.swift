//
//  SceneDelegate.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 15.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator : Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let appCoordinator = AppCoordinator(navigationController: BaseNavController())
        self.appCoordinator = appCoordinator
        
        appCoordinator.window = window
        appCoordinator.start()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
       
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
     
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
      
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

