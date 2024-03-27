//
//  ObstaclesVIew.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 15.02.2024.
//

import Foundation

protocol ObstaclesDelegate: AnyObject {
    func setObstacle(obstacle: String?)
    func removeObstacle(obstacle: String?)
}

final class ObstaclesView : SelectionMenu {
    
    private var selectables : [any Selectable]
    
    init(selectables : [any Selectable], section: Int){
        self.selectables = selectables
        super.init(section: section)
        setTitles(title: selectables)
        allowMultiplySelection = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: ObstaclesDelegate? {
        didSet {
            setObstacle()
        }
    }
    
    private func setObstacle() {
        didSelectButton = { [weak self] buttonText in
            self?.delegate?.setObstacle(obstacle: buttonText)
        }
        
        didDeselectButton = { [weak self] buttonText in
            self?.delegate?.removeObstacle(obstacle: buttonText)
        }
    }
}
