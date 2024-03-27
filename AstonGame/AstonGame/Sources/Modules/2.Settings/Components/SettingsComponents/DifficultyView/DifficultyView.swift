//
//  DifficultyView.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 15.02.2024.
//

import Foundation

protocol DifficultyDelegate : AnyObject {
    func setDifficulty(difficulty: String?)
}

final class DifficultyView : SelectionMenu {
    
    weak var delegate : DifficultyDelegate? {
        didSet {
            setDifficulty()
        }
    }
    
    private var selectables : [any Selectable]
    
    init(selectables : [any Selectable], section: Int){
        self.selectables = selectables
        super.init(section: section)
        setTitles(title: selectables)
        allowMultiplySelection = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setDifficulty() {
        didSelectButton = { [weak self] difficultyText in
            self?.delegate?.setDifficulty(difficulty: difficultyText)
        }
    }
}

