//
//  VehicleCell.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 16.02.2024.
//

import Foundation
import SnapKit
import UIKit

private extension String {
    static let identifier = "VehicleCell"
}

class VehicleCell : UICollectionViewCell {
    
    static let identifier = String.identifier
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureAppearance()
        addViews()
        layoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setImage(image: UIImage) {
        imageView.image = image
    }
    
    private var imageView = UIImageView()
}

extension VehicleCell {
    
    private func configureAppearance() {
        contentView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
    }
    
    private func addViews() {
        contentView.addSubview(imageView)
    }
    
    private func layoutConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
}
