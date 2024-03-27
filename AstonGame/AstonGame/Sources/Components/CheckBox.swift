//
//  CheckBox.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 17.02.2024.
//

import UIKit


/* 
 Данный класс используется как внутренний объект для RadioButton
 */
final class CheckBox: UIButton {
    
    private var checkedImage : UIImage? = C.Images.Buttons.isChecked?.imageResized(to: CGSize(width: 20, height: 20))
    private var uncheckedImage : UIImage? = C.Images.Buttons.nonChecked?.imageResized(to: CGSize(width: 20, height: 20))
    
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                setImage(checkedImage?.withTintColor(C.Colors.nonActive, renderingMode: .alwaysOriginal), for: .normal)
            } else {
                setImage(uncheckedImage?.withTintColor(C.Colors.active, renderingMode: .alwaysOriginal), for: .normal)
            }
        }
    }
    
    var indexPath = IndexPath()
}
