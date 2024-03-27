//
//  StarView.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 26.02.2024.
//

import Foundation
import UIKit

final class CircleView: UIView {
    private var text: String = ""
    
    func text(_ text: String) {
        self.text = text
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
           
        guard let context = UIGraphicsGetCurrentContext() else { return }
                   
        // Определяем размеры круга
        let circleRect = CGRect(x: 3, y: 3, width: rect.width - 6, height: rect.height - 6)

        // Рисуем круг с толщиной бордера
        context.setFillColor(C.Colors.active.cgColor)
        context.fillEllipse(in: circleRect)
        context.setStrokeColor(UIColor.white.cgColor)
        context.setLineWidth(3.0)
        context.strokeEllipse(in: circleRect)

        // Добавляем текст
        let attributes: [NSAttributedString.Key: Any] = [
           .font: UIFont.systemFont(ofSize: 20.0),
           .foregroundColor: UIColor.black
        ]
        let textSize = text.size(withAttributes: attributes)
        let textOrigin = CGPoint(x: (rect.width - textSize.width) / 2, y: (rect.height - textSize.height) / 2)
        let textRect = CGRect(origin: textOrigin, size: textSize)
        text.draw(in: textRect, withAttributes: attributes)
        }
    }

