//
//  +UIView.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 15.02.2024.
//

import UIKit

extension UIView {
    
    func animateTouch(_ button: UIButton) {
         button.addTarget(self, action: #selector(handleIn), for: [.touchDown, .touchDragInside])
         
         button.addTarget(self, action: #selector(handleOut), for: [.touchCancel, .touchDragOutside, .touchUpOutside, .touchUpInside, .touchDragExit])
        
     }
     
     @objc func handleIn() {
         UIView.animate(withDuration: 0.15) {
             self.alpha = 0.55
         }
     }
     
     @objc func handleOut() {
         UIView.animate(withDuration: 0.15) {
             self.alpha = 1
         }
     }
    
    func dropShadow() {
           layer.masksToBounds = false
           layer.shadowColor = UIColor.black.cgColor
           layer.shadowOpacity = 0.5
           layer.shadowOffset = CGSize(width: -1, height: 1)
           layer.shadowRadius = 1
           layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
           layer.shouldRasterize = true
           layer.rasterizationScale = UIScreen.main.scale
       }
    
    func roundCorners(corners: CACornerMask, radius: CGFloat) {
            layer.cornerRadius = radius
            layer.masksToBounds = true
            layer.maskedCorners = corners
        }
    
}
