//
//  CommonView.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 15.02.2024.
//

import Foundation
import SnapKit
import UIKit

private extension CGFloat {
    static let cornerRadius : CGFloat = 1
    static let separatorAlphaComponent : CGFloat = 0.4
}

//MARK: - CommonView является родительским для всех вьюх, находящихся на экране SettingsController

public class CommonView : CustomView {
    
    private let titleLabel = UILabel()
    private var builderView = CustomView()
    public var separator = UIView()
    
    public func setView(title: String, view: CustomView) {
        titleLabel.text = title        
        setupView(view: view)
    }
    
    private func setupView(view: CustomView) {
        builderView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CommonView {
    
    override func configureAppearance() {
        super.configureAppearance()
        
        titleLabel.font = UIFont.C.rubik(size: .subtitle, type: .title)
        titleLabel.textColor = C.Colors.nonActive
        
        separator.backgroundColor = C.Colors.nonActive.withAlphaComponent(.separatorAlphaComponent)
        separator.layer.cornerRadius = .cornerRadius
        separator.clipsToBounds = true
    }
    
    override func addViews() {
        super.addViews()
        addSubview(titleLabel)
        addSubview(builderView)
        addSubview(separator)
    }
    
    override func layoutConstraints() {
        super.layoutConstraints()
                
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(C.Offsets.mediumOffset)
        }
        
        builderView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(C.Offsets.mediumOffset)
            make.top.equalTo(titleLabel.snp.bottom).offset(C.Offsets.mediumOffset)
            make.bottom.equalToSuperview().offset(-C.Offsets.mediumOffset).priority(.low)
            make.trailing.equalToSuperview().inset(C.Offsets.mediumOffset).priority(.high)
        }
        
        separator.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(C.Offsets.mediumOffset)
            make.top.equalTo(builderView.snp.bottom).offset(C.Offsets.mediumOffset)
            make.trailing.equalToSuperview().inset(C.Offsets.mediumOffset).priority(.high)
            make.height.equalTo(2)
        }
    }
}
