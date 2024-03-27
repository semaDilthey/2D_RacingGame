//
//  VehicleView.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 15.02.2024.
//

import Foundation
import SnapKit
import UIKit

protocol VehicleDelegate : AnyObject {
    func selectedVehicle(vehicle: String?)
}

fileprivate enum Constantats {
    static var buttonSize = CGSize(width: 30, height: 50)
    
}

final class VehicleView : CustomView {
    
    weak var delegate: VehicleDelegate?
    
    var currentIndex = 0

    var vehicles : [VehicleType]
    
    init() {
        vehicles = VehicleType.allCases
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var collectionView : UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    private lazy var backButton = UIButton()
    private lazy var forwardButton = UIButton()
    
    private let vehicleLabel = UILabel()
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(VehicleCell.self, forCellWithReuseIdentifier: VehicleCell.identifier)
        
        collectionView.collectionViewLayout = createLayout()
        collectionView.isUserInteractionEnabled = false
    }
    
    private func configureButtons() {
        backButton.setImage(C.Images.Buttons.backButton, for: .normal)
        backButton.animateTouch(backButton)
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        
        forwardButton.setImage(C.Images.Buttons.forwardButton, for: .normal)
        forwardButton.animateTouch(forwardButton)
        forwardButton.addTarget(self, action: #selector(forwardButtonPressed), for: .touchUpInside)
    }
    
    @objc private func backButtonPressed() {
        if currentIndex <= vehicles.count-1 && currentIndex > 0 {
            currentIndex -= 1
            scrollTo(index: currentIndex)
        } else {
            return
        }
    }
    
    @objc private func forwardButtonPressed() {
        if currentIndex < vehicles.count-1 && currentIndex >= 0 {
            currentIndex += 1
            scrollTo(index: currentIndex)
        } else {
            return
        }
    }
    
    private func scrollTo(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
        vehicleLabel.text = vehicles[index].rawValue
        delegate?.selectedVehicle(vehicle: vehicles[index].rawValue)
    }
    
}

extension VehicleView {
    
    override func configureAppearance() {
        super.configureAppearance()
        
        delegate?.selectedVehicle(vehicle: vehicles[0].rawValue)
        configureCollectionView()
        configureButtons()
        
        vehicleLabel.text = vehicles[currentIndex].rawValue
        vehicleLabel.font = UIFont.C.rubik(size: .small, type: .subtitle)
        vehicleLabel.textColor = C.Colors.nonActive
    }
    
    override func addViews() {
        addSubview(collectionView)
        addSubview(backButton)
        addSubview(forwardButton)
        
        addSubview(vehicleLabel)
    }
    
    override func layoutConstraints() {
        
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().inset(C.Offsets.mediumOffset)
            make.centerX.equalToSuperview()
            make.width.equalTo(150)
        }
        
        backButton.snp.makeConstraints { make in
            make.trailing.equalTo(collectionView.snp.leading).offset(-C.Offsets.mediumOffset - backButton.frame.width)
            make.top.equalToSuperview().offset(C.Offsets.mediumOffset)
            make.height.equalTo(Constantats.buttonSize.height)
            make.width.equalTo(Constantats.buttonSize.width)
        }
        
        forwardButton.snp.makeConstraints { make in
            make.leading.equalTo(collectionView.snp.trailing).offset(C.Offsets.mediumOffset)
            make.top.equalToSuperview().offset(C.Offsets.mediumOffset)
            make.height.equalTo(Constantats.buttonSize.height)
            make.width.equalTo(Constantats.buttonSize.width)
        }
        
        vehicleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(collectionView.snp.bottom).offset(C.Offsets.smallOffset/2)
        }
    }
}

extension VehicleView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vehicles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VehicleCell.identifier, for: indexPath) as! VehicleCell
        let image = vehicles[indexPath.row].image.rotate(radians: .pi/2)
        cell.setImage(image: image)
        return cell
    }
}
