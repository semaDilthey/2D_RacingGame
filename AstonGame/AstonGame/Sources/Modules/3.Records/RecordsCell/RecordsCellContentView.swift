//
//  RecordsCellContentView.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 21.02.2024.
//

import Foundation
import SnapKit
import UIKit

fileprivate enum Constantss {
    static var imageHeight = 64 - C.Offsets.smallOffset*2
}

final class RecordsCellContentView : CustomView {
    
    private let playerImage = UIImageView()
    private let playerName = UILabel()
    private let scores = UILabel()
    
    public func configureView(with player: RecordsCellModel) {
        playerName.text = player.name
        if let playerPhoto = player.image {
            playerImage.image = playerPhoto
        }
        if let score = player.score {
            scores.text = "\(score)"
        }
    }
    
    public func prepareForReuse() {
        playerImage.image = nil
        playerName.text = nil
        scores.text = nil
    }
    
    private func configureUI() {
        playerImage.image = C.Images.profileImage
        playerImage.layer.borderColor = UIColor.white.cgColor
        playerImage.layer.borderWidth = 2
        playerImage.clipsToBounds = true
        
        playerName.font = UIFont.C.rubik(size: .small, type: .subtitle)
        scores.font = UIFont.C.rubik(size: .small, type: .subtitle)
    }
}

extension RecordsCellContentView {
    
    override func configureAppearance() {
        configureUI()
    }
    
    override func addViews() {
        addSubview(playerImage)
        addSubview(playerName)
        addSubview(scores)
    }
    
    override func layoutConstraints() {
        
        playerImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(C.Offsets.smallOffset/2)
            make.centerY.equalToSuperview()
            make.width.equalTo(Constantss.imageHeight)
            make.height.equalTo(Constantss.imageHeight)
        }
        
        playerName.snp.makeConstraints { make in
            make.leading.equalTo(playerImage.snp.trailing).offset(C.Offsets.smallOffset)
            make.centerY.equalToSuperview()
        }
        
        scores.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(C.Offsets.smallOffset)
            make.centerY.equalToSuperview()
        }
    }
}
