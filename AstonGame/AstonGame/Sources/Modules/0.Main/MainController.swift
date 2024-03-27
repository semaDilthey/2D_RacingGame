//
//  ViewController.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 15.02.2024.
//

import UIKit
import Lottie

fileprivate enum Constants {
    static var buttonsTopInset : CGFloat = UIScreen.main.bounds.height * 0.44
    static var buttonHeight : CGFloat = C.Offsets.Button.height*4

}

final class MainController: BaseViewController {
    
    //MARK: - Properties
    
    private(set) var viewModel : MainVMProtocol
    
    //MARK: - Init
    
    init(viewModel: MainVMProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    //MARK: - UI Elements
    
    private var animationView = LottieView(lottie: C.Images.Animations.car)
    private lazy var startButton = MenuButton()
    private lazy var settingsButton = MenuButton()
    private lazy var recordsButton = MenuButton()

    //MARK: - @objc Methods
    
    @objc func didTappedStart() {
        viewModel.startGame(controller: self)
    }
    
    @objc func didTappedSettings() {
        viewModel.presentSettingsController(output: self)
    }
    
    @objc func didTappedRecords() {
        viewModel.presentRecordsController()
    }
}

extension MainController {
    
    //MARK: - Overriding parent methods
    
    override func configureView() {
        super.configureView()
                
        startButton.configure(with: C.Strings.Buttons.start, target: self, action: #selector(didTappedStart))
        startButton.setColor(color: C.Colors.green)
        
        settingsButton.configure(with: C.Strings.Buttons.settings.uppercased(), target: self, action: #selector(didTappedSettings))
        settingsButton.setColor(color: C.Colors.orange)
        
        recordsButton.configure(with: C.Strings.Buttons.records, target: self, action: #selector(didTappedRecords))
        recordsButton.setColor(color: C.Colors.red)

    }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(animationView)
    }
    
    override func layoutConstraints() {
        super.layoutConstraints()
                
        let buttonsStack = UIStackView.init(arrangedSubviews: [startButton, settingsButton, recordsButton], axis: .vertical, spacing: C.Offsets.mediumOffset, alignment: .fill, distribution: .fillEqually)
        view.addSubview(buttonsStack)
        
        buttonsStack.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(C.Offsets.Button.sidesOffset)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(C.Offsets.Button.sidesOffset)
            make.height.equalTo(Constants.buttonHeight + buttonsStack.spacing*2)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(Constants.buttonsTopInset)
        }
        
        animationView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.4)
            make.bottom.equalTo(buttonsStack.snp.top)
        }

    }
}

//MARK: - SettingsCOntroller GameData delegate

extension MainController : SettingsOutput {
    
    func didUpdateGameData(gameData: GameData) {
        self.viewModel.setGameData(gameData: gameData)
    }
    
}


