//
//  LottieAnimationView.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 26.02.2024.
//

import Foundation
import UIKit
import SnapKit
import Lottie

final class LottieView : CustomView {
    
    init(lottie: String) {
        animationView = .init(name: lottie)
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        animationView.pause()
    }
    
    private var animationView = LottieAnimationView()
    
}


extension LottieView {
    
    override func configureAppearance() {
        animationView.loopMode = .loop
        animationView.play()
    }
    
    override func addViews() {
        addSubview(animationView)
    }
    
    override func layoutConstraints() {
        
        animationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
