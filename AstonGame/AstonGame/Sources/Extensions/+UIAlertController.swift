//
//  +UIAlertController.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 13.03.2024.
//

import Foundation
import UIKit

extension UIAlertController {
    
    convenience init(title: String, message: String?, actionCompletion: (()->())?) {
        self.init(title: title, message: message, preferredStyle: .alert)
        
            let action = UIAlertAction(title: Actions.createAction.rawValue, style: .cancel) { _ in
                actionCompletion?()
            }
            let cancelAction = UIAlertAction(title: Actions.cancelAction.rawValue,
                                                                 style: .destructive)
            addAction(action)
            addAction(cancelAction)
    }
    
    private enum Actions: String {
        case createAction = "Ok"
        case cancelAction = "Cancel"
    }

}
