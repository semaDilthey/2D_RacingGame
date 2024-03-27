//
//  RecordsViewModel.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 03.03.2024.
//

import Foundation

fileprivate enum Constants {
    static let playersLimit = 10
}

protocol RecordsVMProtocol: BaseViewModelProtocol {
    var records : [Player] { get set }
    var reloadTable : (()->())? { get set }
    func fetchRecords()
    func getNumberOfRows() -> Int
    func getModelForCell(at indexPath: IndexPath) -> RecordsCellModel?
}

final class RecordsViewModel: BaseViewModel, RecordsVMProtocol {
    
    private var dataStorage : Persistable
    
    init(coordinator: Coordinator?, dataStorage: Persistable = DataStorage()) {
        self.dataStorage = dataStorage
        super.init(coordinator: coordinator)
    }
    
    var reloadTable : (()->())?

    var records : [Player] = [] {
        didSet {
          reloadTable?()
        }
    }
    
    public func fetchRecords() {
        if let records = dataStorage.getRecords() {
            self.records = records
        }
    }
    
    public func getNumberOfRows() -> Int {
        if records.count > Constants.playersLimit {
            return Constants.playersLimit
        } else {
            return records.count
        }
    }
    
    func getModelForCell(at indexPath: IndexPath) -> RecordsCellModel? {
        guard indexPath.row <= records.count else { return nil }
        return RecordsCellModel(name: records[indexPath.row].name, score: records[indexPath.row].score, image: records[indexPath.row].photo)
    }
    
    
}
