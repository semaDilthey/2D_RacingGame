//
//  Base.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 15.02.2024.
//

import Foundation
import UIKit

@objc protocol BaseInterface {
    func configureView()
    func layoutConstraints()
    func addSubviews()
    func navBarLeftItemHandler()
    func startAnimations()
    func stopAnimations()
}

class BaseViewController: UIViewController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        addSubviews()
        layoutConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startAnimations()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopAnimations()
    }

    //MARK: - NaviationBar UI Elements
    
    private lazy var leftButton : MenuButton = {
        let button = MenuButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
        
    private var titleLabel : UILabel = {
        let title = UILabel()
        title.font = UIFont.C.rubik(size: .title, type: .title)
        title.textColor = C.Colors.nonActive
        return title
    } ()
}

extension BaseViewController: BaseInterface {
    
    func configureView() {
        view.backgroundColor = C.Colors.background
        navigationController?.navigationBar.tintColor = C.Colors.active
    }
    
    func layoutConstraints() {}
    func addSubviews() {}
    
    func navBarLeftItemHandler() {
        print("Left selector was tapped")
    }
    
    func startAnimations() {}
    
    func stopAnimations() {}
}

enum NavBarPosition {
    case left(type: NavBarItemType)
//    case right(type: NavBarItemType)
    case center
}

enum NavBarItemType {
    case button(image: UIImage? = nil)
    case label
}

extension BaseViewController {
    
    func addNavBarItem(at position: NavBarPosition, title : String? = nil) {

        switch position {
        case .left(let type):
            
            switch type {
            case .button:
                leftButton.configure(with: title ?? "", target: self, 
                                     action: #selector(navBarLeftItemHandler))
                leftButton.setColor(color: C.Colors.orange)
                leftButton.animateTouch(leftButton)
                let desiredWidth = 60.0
                let desiredHeight = 40.0

                let widthConstraint = NSLayoutConstraint(item: leftButton, 
                                                         attribute: .width,
                                                         relatedBy: .equal,
                                                         toItem: nil,
                                                         attribute: .notAnAttribute,
                                                         multiplier: 1.0,
                                                         constant: desiredWidth)
                
                let heightConstraint = NSLayoutConstraint(item: leftButton, 
                                                          attribute: .height,
                                                          relatedBy: .equal,
                                                          toItem: nil,
                                                          attribute: .notAnAttribute,
                                                          multiplier: 1.0,
                                                          constant: desiredHeight)
                
                leftButton.addConstraints([widthConstraint, heightConstraint])
                navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
                
            case .label:
                titleLabel.text = title
                navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleLabel)
            }
            
        case .center:
            titleLabel.text = title
            navigationItem.titleView = titleLabel
        }
    }
}
