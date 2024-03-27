//
//  SelectionMenu.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 17.02.2024.
//

import Foundation
import SnapKit
import UIKit

public class SelectionMenu : CustomView {
    // При нажатии на кнопку отдает в чайлдВью текст кнопки
    var didSelectButton: ((String?)->())?
    var didDeselectButton: ((String?)->())?
    
    var section : Int
    
    init(section: Int) {
        self.section = section
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var allowMultiplySelection = false {
        didSet {
            allowMultiplySelection ? multiplyButtonsSelection() : singleButtonSelection()
        }
    }
    
    private var button1 = RadioButton()
    private var button2 = RadioButton()
    private var button3 = RadioButton()
    
    // Ставим титлы для кнопок
    func setTitles(title: [any Selectable]) {
        guard title.count >= 3 else {
            fatalError("Not enough selectable items provided.")
        }
        button1.setTitle(title: title[0].rawValue)
        button2.setTitle(title: title[1].rawValue)
        button3.setTitle(title: title[2].rawValue)
        
    }
    
    // в случае если allowMultiplySelection == false, то есть разрешаем выбирать только 1 кнопку, то вызываем это
    private func singleButtonSelection() {
        for button in [button1, button2, button3] {
            button.onTap = { [weak self] buttonText in
                self?.selectOneButton(button)
                self?.didSelectButton?(buttonText)
            }
//            button.buttonType(type: .radioButton)
        }
    }
    
    // в случае если allowMultiplySelection == true, то есть разрешаем выбирать несколько кнопок, то вызываем это
    private func multiplyButtonsSelection() {
        for button in [button1, button2, button3] {
            button.onTap = { [weak self] buttonText in
                self?.selectMultiplyButtons(button, buttonText: buttonText)
            }
//            button.buttonType(type: .checkBox)
        }
        layoutSubviews()
        layoutIfNeeded()
    }
    
    // выбираем 1 кнопку
    private func selectOneButton(_ selectedButton: RadioButton?) {
        guard let selectedButton = selectedButton else { return }
        button1.isSelected = false
        button2.isSelected = false
        button3.isSelected = false
        
        selectedButton.isSelected = true
        selectedButton.animateTitle()
    }
    
    // Можем выбирать все кнопки. Но надо настроить работает криво.
    
    private var selectedButtons = Set<RadioButton>()

    private func selectMultiplyButtons(_ button: RadioButton, buttonText: String?) {
        if selectedButtons.contains(button) {
            selectedButtons.remove(button)
            didDeselectButton?(buttonText)
            button.isSelected = false
            button.animateTitle()
        } else {
            selectedButtons.insert(button)
            self.didSelectButton?(buttonText)
            button.isSelected = true
            button.animateTitle()
        }
    }
    
    
    private func setIndexPaths(for buttons: [RadioButton]) {
        var indexx = 0
        buttons.forEach { button in
            button.indexPath = IndexPath(row: indexx, section: section)
            indexx += 1
        }
        setupSelectedButton(buttons: buttons)
    }
    
    #warning("При старте выбрана кнопка с индексом 0. Но данные в сеттингсVC еще не отдаются. Поработать над этим")
    // Кнопка с индексом 0 выбрана при старте
    private func setupSelectedButton(buttons: [RadioButton]) {
        buttons[0].isSelected = true
        selectedButtons.insert(buttons[0])
        didSelectButton?(buttons[0].buttonTitle.text)
    }
}

extension SelectionMenu {
    
    override func configureAppearance() {
        super.configureAppearance()
        
        setIndexPaths(for: [button1, button2, button3])
    }

    
    override func layoutConstraints() {
        
        let vStack = UIStackView(arrangedSubviews: [button1, button2, button3], axis: .vertical, spacing: C.Offsets.smallOffset, distribution: .fillEqually)
        addSubview(vStack)
        vStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
}
