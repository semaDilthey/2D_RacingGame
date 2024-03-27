//
//  Constants.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 15.02.2024.
//

import UIKit

enum C {
    
    //MARK: - Colors
    enum Colors {
        static var active = UIColor.init(hexString: "#E4B007")
        static var nonActive = UIColor.init(hexString: "#F0EEFB")
        static var background = UIColor.init(hexString: "#786DF8")
        static var road = UIColor.init(hexString: "#1D1D1D")
        static var roadMark = UIColor.init(hexString: "#A3851F")
        
        static var orange = active
        static var green = UIColor.init(hexString: "#67B820")
        static var red = UIColor.init(hexString: "#E2463B")
        
        static var accentDark = UIColor.init(hexString: "#191855")
    }
    
    //MARK: - Offsets

    enum Offsets {
        static var bigOffset : CGFloat = 24
        static var mediumOffset : CGFloat = 16
        static var smallOffset : CGFloat = 8
        
        static var cornerRadius : CGFloat = 8
        
        static var borderWidth : CGFloat = 3
        
        enum Button {
            static var height : CGFloat = UIScreen.main.bounds.height/20
            static var sidesOffset: CGFloat = 48
        }
    }
    
    //MARK: - Strings

    enum Strings {
        
        enum Entity {
            static var playerEntity = "PlayerEntity"
        }
        
        enum Titles {
            static var settings = "Settings"
        }
        
        enum Labels {
            static var scores = "Score:"
        }
        
        enum Buttons {
            static var back = "Back"
            static var start = "START"
            static var settings = "Settings"
            static var records = "RECORDS"
            static let saveSettings = "Save settings"
        }
        
        enum Settings {
            
            enum Vehicles {
                static var car = "Car"
                static var bike = "Bike"
                static var cargo = "Cargo"
            }
            
            enum Obstacles {
                static var rock = "Rock"
                static var tree = "Tree"
                static var garbage = "Garbage"
            }
            
            enum Difficulty {
                static var easy = "Easy"
                static var medium = "Medium"
                static var hard = "Hard"
            }
        }
    }
    
    //MARK: - Images
    
    enum Images {
        static var profileImage = UIImage(named: "profileImage")!
        static var backgrpund = UIImage(named: "asphalt_background")
        
        enum Buttons {
            static var forwardButton = UIImage(named: "rightArrow")
            static var backButton = UIImage(named: "rightArrow")?.rotate(radians: .pi)
            
            static var isChecked = UIImage(named: "isChecked")
            static var nonChecked = UIImage(named: "nonChecked")
            static var changePhoto = UIImage(named: "changePhoto")
        }
        
        enum Objects {
            enum Vehicles {
                static var car = UIImage(named: "car")
                static var bike = UIImage(named: "bike")
                static var cargo = UIImage(named: "cargo")

            }
            
            enum Obstacles {
                static var rock = UIImage(named: "rock")
                static var tree = UIImage(named: "tree")
                static var garbage = UIImage(named: "garbage")

            }
        }
        
        enum Animations {
            static var car = "lottie_car"
            static var congrats = "lottie_congrats"
            static var stars = "lottie_stars"
        }
        
    }
    
    enum Default {
        static var player = Player(name: "No name")
        static var settings = Settings(difficulty: .easy, vehicle: .car, obstacles: [.tree])
    }
}
