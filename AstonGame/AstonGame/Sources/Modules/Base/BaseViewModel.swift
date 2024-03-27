//
//  BaseViewModel.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 06.03.2024.
//

import Foundation

protocol BaseViewModelProtocol {
    func dismiss()
}

public class BaseViewModel: BaseViewModelProtocol {
    
    let coordinator: Coordinator?
    
    init(coordinator: Coordinator?) {
        self.coordinator = coordinator
    }
    
    func dismiss() {
        coordinator?.dismiss()
    }
}
