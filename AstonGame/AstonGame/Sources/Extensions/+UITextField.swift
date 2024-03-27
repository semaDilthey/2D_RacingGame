//
//  +UITextField.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 26.02.2024.
//

import Foundation
import UIKit

extension UITextField {
    
    func inset(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
    
}
