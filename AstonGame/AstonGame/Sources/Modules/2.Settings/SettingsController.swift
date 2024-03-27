//
//  SettingsController.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 15.02.2024.
//

import Foundation
import UIKit

protocol SettingsOutput: AnyObject {
    // Обновляет модель игры при нажатии кнопки "Save"
    func didUpdateGameData(gameData: GameData)
}

fileprivate enum Constants {
    
    enum Heights  {
        static var userView: CGFloat = 70
        static var vehicleView: CGFloat = 170
        static var obstaclesView: CGFloat = 200
        static var difficultyView: CGFloat = 200
    }
}


final class SettingsController: BaseViewController {
    
    //MARK: - Properties
    
    private let viewModel: SettingsVMProtocol
    private var viewsFactory : SettingViewsFactory
    
    weak var output: SettingsOutput?
    
    //MARK: - Initialization
    
    init(viewModel: SettingsVMProtocol, viewsFactory : SettingViewsFactory = DefaultSettingsViewsFactory()) {
        self.viewModel = viewModel
        self.viewsFactory = viewsFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setScrollViewSize()
    }
        
    //MARK: - UI Elements
    
    private lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isScrollEnabled = true
        return scrollView
    }()
    
    private lazy var userView : UserView = {
        return viewsFactory.makeView(of: .user(delegate: self,
                                               player: viewModel.getLastPlayer())) as! UserView
    }()
    
    private lazy var vehicleView : CommonView = {
        return viewsFactory.makeView(of: .vehicle(delegate: self)) as! CommonView
    }()
    
    private lazy var obstaclesView : CommonView = {
        return viewsFactory.makeView(of: .obstacles(delegate: self)) as! CommonView
    }()
    
    private lazy var difficultyView : CommonView = {
        return viewsFactory.makeView(of: .diffilty(delegate: self)) as! CommonView
    }()
    
    private lazy var saveButton = MenuButton()
    
    //MARK: - Private methods
    
    private func configSaveButton() {
        saveButton.configure(with: C.Strings.Buttons.saveSettings,
                             target: self, 
                             action: #selector(saveTapped))
        saveButton.setColor(color: C.Colors.green)
    }
    
    private func setScrollViewSize() {
        var contentHeight : CGFloat = C.Offsets.mediumOffset * 2
        for view in scrollView.subviews {
            contentHeight += view.frame.height
        }
        self.scrollView.contentSize = CGSize(width: view.bounds.width - C.Offsets.smallOffset*2, height: contentHeight)
    }
     
    //MARK: - @objc Methods
    
    @objc private func saveTapped() {
        print(#function)
        if userView.isFilled {
            output?.didUpdateGameData(gameData: viewModel.getGameData())
        } else {
            let controller = UIAlertController(title: "Enter name", message: nil, actionCompletion: nil)
            present(controller, animated: true)
        }
    }
}

extension SettingsController {
    
    override func configureView() {
        super.configureView()
        configSaveButton()
        addNavBarItem(at: .left(type: .button(image: nil)), title: C.Strings.Buttons.back)
        addNavBarItem(at: .center, title: C.Strings.Titles.settings)
    }
    
    override func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(userView)
        scrollView.addSubview(vehicleView)
        scrollView.addSubview(obstaclesView)
        scrollView.addSubview(difficultyView)
//
        scrollView.addSubview(saveButton)
    }
    
    override func layoutConstraints() {

        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(C.Offsets.smallOffset)
            make.trailing.equalToSuperview().inset(C.Offsets.smallOffset)
        }
        
        userView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(C.Offsets.smallOffset)
            make.leading.equalToSuperview().offset(C.Offsets.mediumOffset)
            make.trailing.equalToSuperview().inset(C.Offsets.mediumOffset)
            make.height.equalTo(Constants.Heights.userView)
            
        }
        
        vehicleView.snp.makeConstraints { make in
            make.top.equalTo(userView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(Constants.Heights.vehicleView)
        }
        
        obstaclesView.snp.makeConstraints { make in
            make.top.equalTo(vehicleView.snp.bottom)
            make.leading.equalToSuperview().offset(C.Offsets.smallOffset)
            make.trailing.equalToSuperview().inset(C.Offsets.smallOffset)
            make.height.equalTo(Constants.Heights.obstaclesView)
        }
        
        difficultyView.snp.makeConstraints { make in
            make.top.equalTo(obstaclesView.snp.bottom)
            make.leading.equalToSuperview().offset(C.Offsets.smallOffset)
            make.trailing.equalToSuperview().inset(C.Offsets.smallOffset)
            make.height.equalTo(Constants.Heights.difficultyView)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(difficultyView.snp.bottom).offset(C.Offsets.mediumOffset)
            make.leading.equalToSuperview().offset(C.Offsets.Button.sidesOffset)
            make.trailing.equalToSuperview().inset(C.Offsets.Button.sidesOffset)
            make.height.equalTo(C.Offsets.Button.height)
        }
    }
    
    override func navBarLeftItemHandler() {
        viewModel.dismiss()
    }
}


//MARK: - Delegates for child views

//MARK: - UserView delegates
extension SettingsController : UserDelegate {
    
    func setUser(name: String?, image: PhotoStatus) {
        viewModel.setUser(name: name, photo: image)
    }
    
    func presentGallery(gallery: UIImagePickerController) {
        self.present(gallery, animated: true)
    }
    
    func dismissGallery(gallery: UIImagePickerController, userImage: PhotoStatus) {
        viewModel.setUser(name: nil, photo: userImage)
        gallery.dismiss(animated: true)
    }
}

//MARK: - DifficultyView delegates

extension SettingsController : DifficultyDelegate {
    
    func setDifficulty(difficulty: String?) {
        viewModel.setDifficulty(difficulty: difficulty)
    }
    
}

//MARK: - ObstaclesView delegates

extension SettingsController: ObstaclesDelegate {
    
    // Срабатывает при выборе нового препятствия
    func setObstacle(obstacle: String?) {
        viewModel.setObstacle(obstacle: obstacle)
    }
    
    // Срабатывает при снятии выбора с препятствия
    func removeObstacle(obstacle: String?) {
        viewModel.removeObstacle(obstacle: obstacle)
    }
}

//MARK: - VehicleView delegates

extension SettingsController: VehicleDelegate {
    
    func selectedVehicle(vehicle: String?) {
        viewModel.setVehicle(vehicle: vehicle)
    }
}
