//
//  Settings.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 17.02.2024.
//

import Foundation
import UIKit

/* 
 Selectable используется как общий интферфейс для методов модели Settings.
 При нем должен реализовываться протокол RawRepresentable, поскольку нам надо "switch back and forth between
 a custom type and an associated RawValue type without losing the value of the original RawRepresentable type"
 */
protocol Selectable: RawRepresentable {
    var rawValue : String { get }
}

struct Settings {
    var difficulty: Difficulty?
    var vehicle: VehicleType?
    var obstacles: [ObstacleType]?
}

//MARK: - Difficulty

enum Difficulty : Selectable, CaseIterable {
    case easy
    case medium
    case hard
    
    init?(rawValue: String) {
        switch rawValue {
        case C.Strings.Settings.Difficulty.easy: self = .easy
        case C.Strings.Settings.Difficulty.medium: self = .medium
        case C.Strings.Settings.Difficulty.hard: self = .hard
        default: return nil
        }
    }
    
    var rawValue : String {
        switch self {
        case .easy:
            C.Strings.Settings.Difficulty.easy
        case .medium:
            C.Strings.Settings.Difficulty.medium
        case .hard:
            C.Strings.Settings.Difficulty.hard
        }
    }
}

//MARK: - Obstacles

enum ObstacleType : Selectable, CaseIterable {
    case tree
    case rock
    case gargbage
    
    init?(rawValue: String) {
        switch rawValue {
        case C.Strings.Settings.Obstacles.tree: self = .tree
        case C.Strings.Settings.Obstacles.rock: self = .rock
        case C.Strings.Settings.Obstacles.garbage: self = .gargbage
        default: return nil
        }
    }
    
    var image : UIImage {
        switch self {
        case .tree:
            C.Images.Objects.Obstacles.tree!
        case .rock:
            C.Images.Objects.Obstacles.rock!
        case .gargbage:
            C.Images.Objects.Obstacles.garbage!
        }
    }
    
    var rawValue : String {
        switch self {
        case .tree:
            C.Strings.Settings.Obstacles.tree
        case .rock:
            C.Strings.Settings.Obstacles.rock
        case .gargbage:
            C.Strings.Settings.Obstacles.garbage
        }
    }
}

//MARK: - Vehicle

enum VehicleType : Selectable ,CaseIterable {
    case car
    case bike
    case cargo
    
    init?(rawValue: String) {
        switch rawValue {
        case C.Strings.Settings.Vehicles.car: self = .car
        case C.Strings.Settings.Vehicles.bike: self = .bike
        case  C.Strings.Settings.Vehicles.cargo: self = .cargo
        default: return nil
        }
    }
    
    var image : UIImage {
        switch self {
        case .car:
            C.Images.Objects.Vehicles.car!
        case .bike:
            C.Images.Objects.Vehicles.bike!
        case .cargo:
            C.Images.Objects.Vehicles.cargo!
        }
    }
    
    var rawValue : String {
        switch self {
        case .car:
            C.Strings.Settings.Vehicles.car
        case .bike:
            C.Strings.Settings.Vehicles.bike
        case .cargo:
            C.Strings.Settings.Vehicles.cargo
        }
    }
}
