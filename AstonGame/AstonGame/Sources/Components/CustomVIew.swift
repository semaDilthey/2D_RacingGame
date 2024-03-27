//
//  CustomVIew.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 15.02.2024.
//

import UIKit

/*
 Родительский view для всех кастомных View в проекте
 */

public class CustomView : UIView {
    
    enum Constants {
        static var borderWidth : CGFloat = 1
        static var cornerRadius : CGFloat = 8
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureAppearance()
        addViews()
        layoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

@objc extension CustomView {
    
    func configureAppearance() {
//        layer.borderWidth = Constants.borderWidth
        layer.cornerRadius = Constants.cornerRadius
//        layer.borderColor = C.Colors.accentDark.cgColor
        
    }
    func addViews() {}
    func layoutConstraints() {}
}
