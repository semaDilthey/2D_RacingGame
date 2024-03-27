//
//  FinishView.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 20.02.2024.
//

import Foundation
import SnapKit
import UIKit

enum RaceResult : Int, RawRepresentable {
    case zero
    case bad
    case notBad
    case great
    
    init?(rawValue: Int) {
        switch rawValue {
        case 0: self = .zero
        case 1...10: self = .bad
        case 11...50: self = .notBad
        case 51...999999: self = .great
        default: self = .great
        }
    }
    
    var string : String {
        switch self {
        case .zero:
            return "Может лучше поспать?"
        case .bad:
            return "Вы можете лучше"
        case .notBad:
            return "Неплохо, но может еще разок?"
        case .great:
            return "Вы сегодня на коне!"
        }
    }
}

protocol FinishViewDelegate: AnyObject {
    func returnToRootController()
}

final class FinishView : CustomView {
    
    weak var delegate : FinishViewDelegate?
    
    private let containerView = UIView()
        
    private var resultLabel = CircleView()
    private var text = UILabel()
    
    private lazy var returnButton = MenuButton()
    
    init(frame: CGRect, result: Int) {
        defer { setLabels(with: result) }
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLabels(with result: Int) {
        resultLabel.text("\(result)")
        text.text = RaceResult(rawValue: result)?.string
    }
    
    @objc private func returnPressed() {
        delegate?.returnToRootController()
    }
}


extension FinishView {
    
    override func configureAppearance() {
        super.configureAppearance()
        
        backgroundColor = C.Colors.green
//        dropShadow()
        
        containerView.backgroundColor = .clear
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.borderWidth = 3
        containerView.layer.cornerRadius = C.Offsets.cornerRadius
        containerView.clipsToBounds = true
        
        resultLabel.backgroundColor = .clear
        
        text.numberOfLines = 0
        text.textAlignment = .center
        text.lineBreakStrategy = .standard
        
        returnButton.configure(with: "Вернуться", target: self, action: #selector(returnPressed))
        returnButton.setColor(color: C.Colors.red)
        
    }
    
    override func addViews() {
        addSubview(containerView)
        
        addSubview(resultLabel)
        addSubview(text)
        
        addSubview(returnButton)
    }
    
    override func layoutConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(C.Offsets.mediumOffset)
            make.trailing.bottom.equalToSuperview().inset(C.Offsets.mediumOffset)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(C.Offsets.mediumOffset)
            make.centerX.equalTo(containerView)
            make.height.width.equalTo(30)
        }
        
        text.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(C.Offsets.mediumOffset)
            make.trailing.equalTo(containerView.snp.trailing).inset(C.Offsets.smallOffset/2)
            make.leading.equalTo(containerView.snp.leading).offset(C.Offsets.smallOffset/2)
            make.centerX.equalTo(containerView)
        }
        
        returnButton.snp.makeConstraints { make in
            make.bottom.equalTo(containerView.snp.bottom).offset(-C.Offsets.smallOffset)
            make.leading.equalTo(containerView.snp.leading).offset(C.Offsets.Button.sidesOffset/2)
            make.trailing.equalTo(containerView.snp.trailing).offset(-C.Offsets.Button.sidesOffset/2)
            make.height.equalTo(C.Offsets.Button.height)
        }
    }
    
}


extension FinishView {
    
    convenience init(parent: UIViewController, result: Int, width: CGFloat, height: CGFloat) {
        let x = parent.view.frame.width/2-width/2
        let y = parent.view.frame.height/2 - height/2
        self.init(frame: CGRect(x: x, y: y, width: width, height: height),
                  result: result)
       delegate = parent as! any FinishViewDelegate
        parent.view.addSubview(self)
    }

}
