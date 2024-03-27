//
//  +UIStackView.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 15.02.2024.
//

import Foundation
import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat = 0.0,
                     alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) {
            self.init()

            self.axis = axis
            self.spacing = spacing
            self.alignment = alignment
            self.distribution = distribution

            arrangedSubviews.forEach { self.addArrangedSubview($0) }
        }
    
}
