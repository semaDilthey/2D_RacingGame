//
//  GameView.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 19.02.2024.
//

import Foundation
import SnapKit
import UIKit

class GameObject : CustomView {
    var imageView = UIImageView()
}


extension GameObject {
    
    override func configureAppearance() {
        imageView.contentMode = .scaleAspectFill
    }
    
    override func addViews() {
        addSubview(imageView)
    }
    
    override func layoutConstraints() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension GameObject {
    
    // Визуальная настройка нашего игрока
    func setupPlayer(parent: UIViewController, image: UIImage?, size: CGSize, action: Selector) {
        let playerSize = size
        let playerOrigin = CGPoint(x: parent.view.center.x - playerSize.width/2, y: parent.view.frame.height - playerSize.height - 130)
        frame = CGRect(origin: playerOrigin, size: playerSize)
        let panGestureRecognizer = UIPanGestureRecognizer(target: parent, action: action)
        addGestureRecognizer(panGestureRecognizer)
        imageView.image = image
    }
}


extension GameObject {
    
    // Инициализатор для препятствия
    convenience init(parent: UIViewController, size: CGSize, image: UIImage?) {
        self.init(frame: .zero)
        let randomX = CGFloat.random(in: 0...(parent.view.frame.width - size.width))
        frame = CGRect(origin: CGPoint(x: randomX, y: -size.height), size: size)
        imageView.image = image
        layer.cornerRadius = size.height/2
    }
    
    // Инициализатор для дорожных полос
    convenience init(parent: UIViewController, size: CGSize) {
        self.init(frame: .zero)
        frame = CGRect(origin: CGPoint(x: parent.view.frame.width/2 - size.width/2, y: -size.height), size: size)
        backgroundColor = C.Colors.roadMark
        clipsToBounds = true
        layer.zPosition = -1
    }
}
