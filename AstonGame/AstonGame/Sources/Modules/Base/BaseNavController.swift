//
//  BaseNavControlle.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 15.02.2024.
//

import UIKit

class BaseNavController : UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = C.Colors.background
        navBarAppearance.titleTextAttributes = [.foregroundColor : UIColor.white, .font : UIFont.C.rubik(size: .title, type: .title) as Any]
        navBarAppearance.shadowColor = C.Colors.background

        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationBar.isTranslucent = false
    }
}
