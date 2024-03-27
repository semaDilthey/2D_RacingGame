//
//  MenuButton.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 15.02.2024.
//

import Foundation
import UIKit

/*
 MenuButton может использоваться как кнопка в меню, кнопка сохранить или любая другая большая кнопка
 Подписывается под протокол MenuButtonProtocol для более детальной настройки
 -
 configure(with title: String, target: Any?, action: Selector) - устанавливает заголовк кнопке, и экшен
 -
 setColor(color: UIColor) - задаем цвет бэкграунда
 */

protocol MenuButtonProtocol {
    func configure(with title: String, target: Any?, action: Selector)
    func setColor(color: UIColor)
}

final class MenuButton : UIButton {
    
    private enum Constants {
        static var borderWidth : CGFloat = 3
        static var cornerRadius : CGFloat = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        titleLabel?.font = UIFont.C.rubik(size: .small, type: .title)
        animateTouch(self)
        
        layer.borderWidth = Constants.borderWidth
        layer.cornerRadius = Constants.cornerRadius
        layer.borderColor = UIColor.white.cgColor
        backgroundColor = C.Colors.nonActive
        
        setTitleColor(.white, for: .normal)
        tintColor = C.Colors.active
    }
}

extension MenuButton : MenuButtonProtocol {
    
    public func configure(with title: String, target: Any?, action: Selector) {
        setTitle(title, for: .normal)
        addTarget(target, action: action, for: .touchUpInside)
    }
    
    public func setColor(color: UIColor) {
        backgroundColor = color
    }
    
    public func setTitle(title: String) {
        setTitle(title, for: .normal)
    }
    
}


