//
//  +UIFont.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 28.02.2024.
//

import UIKit

extension UIFont {
    
    enum C {
        
        enum TunnelFront: Int {
            case small
            case subtitle
            case title
            
            var nameFont: String {
                return "TunnelFront"
            }
            
            var size : CGFloat {
                switch self {
                case .small:
                    return 16
                case .subtitle:
                    return 24
                case .title:
                    return 32
                }
            }
        }
        
        enum RubicFont : Int {
            case small
            case subtitle
            case title
            
            var nameFont: String {
                switch self {
                case .small:
                    return "Rubik"
                case .subtitle:
                    return "Rubik Medium"
                case .title:
                    return "Rubik Black"
                }
               
            }
            
            var size : CGFloat {
                switch self {
                case .small:
                    return 16
                case .subtitle:
                    return 24
                case .title:
                    return 32
                }
            }
        }
        
        static func tunnelFront(size fontSize: TunnelFront) -> UIFont? {
            UIFont(name: fontSize.nameFont, size: fontSize.size)
        }
        
        static func rubik(size fontSize: RubicFont, type: RubicFont) -> UIFont? {
            UIFont(name: type.nameFont, size: fontSize.size)
        }
        
    }
    
}
