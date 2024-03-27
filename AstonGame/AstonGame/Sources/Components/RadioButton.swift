//
//  RadioButton.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 16.02.2024.
//

import Foundation
import SnapKit
import UIKit


final class RadioButton : CustomView {

    //MARK: - Properties
    // обсервер для настроек состояния кнопки
    var isSelected = false {
        didSet {
            isSelected ? setSelected() : setNonSelected()
        }
    }
    // делает что-то при клике на кнопку
    var onTap : ((String?)->())?
    var indexPath = IndexPath()
    
    //MARK: - UI Elements
    var buttonTitle = UILabel()
    private var checkBox = CheckBox()
    
    //MARK: - Public methods
    public func setTitle(title: String) {
        buttonTitle.text = title
    }
    
    public func animateTitle() {
        startAnimation { [weak self] in
            self?.stopAnimation()
        }
    }
    
    //MARK: - Private methods
    private func setSelected() {
        // Настройки для выбранного состояния
        checkBox.isChecked = true
        self.backgroundColor = C.Colors.active
    }
    
    // Настройки для невыбранного состояния
    private func setNonSelected() {
        checkBox.isChecked = false
        self.backgroundColor = C.Colors.nonActive
    }
    
    private func startAnimation(completion: @escaping (()->())) {
        UIView.animate(withDuration: 0.3, delay: 0,options: .curveEaseInOut) {
            self.buttonTitle.frame.origin.x += 20
        } completion: { _ in
            completion()
        }
    }
    
    private func stopAnimation() {
        UIView.animate(withDuration: 0.3) {
            self.buttonTitle.frame.origin.x -= 20
        }
    }
    
    @objc private func didSelected() {
        isSelected.toggle()
        onTap?(buttonTitle.text)
    }
    
}

extension RadioButton {
    
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = C.Colors.nonActive
        
        buttonTitle.layer.cornerRadius = C.Offsets.cornerRadius
        buttonTitle.clipsToBounds = true
        buttonTitle.font = UIFont.C.rubik(size: .small, type: .subtitle)
        buttonTitle.textColor = .black
        
        checkBox.isChecked = false
        checkBox.indexPath = indexPath
        checkBox.addTarget(self, action: #selector(didSelected), for: .touchUpInside)
    }

    override func addViews() {
        addSubview(buttonTitle)
        addSubview(checkBox)
    }
    
    override func layoutConstraints() {
        
        let hStach = UIStackView(arrangedSubviews: [buttonTitle, checkBox], axis: .horizontal, spacing: 150, distribution: .fillEqually)
        
        addSubview(hStach)
        
        hStach.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(C.Offsets.smallOffset)
            make.top.equalToSuperview().offset(C.Offsets.smallOffset)
            make.bottom.equalToSuperview().inset(C.Offsets.smallOffset)
            make.trailing.equalToSuperview().inset(C.Offsets.mediumOffset)
        }
   
    }
}

