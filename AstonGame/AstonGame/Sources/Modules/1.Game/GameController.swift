//
//  GameController.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 16.02.2024.
//

import Foundation
import SnapKit
import UIKit

final class GameController : BaseViewController {
        
    //MARK: - Init
    private var viewModel: GameVMProtocol

    init(viewModel: GameVMProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        checkForIntersections(with: playerView)
    }
    
    //MARK: - Properties
    
    private var gameTimer: Timer?
    private var roadMarksTimer: Timer?
    private var obstacles: [UIView] = []

    
    //MARK: - UIView elements
    
    private var scoreCountsLabel = CircleView()
    private var playerView = GameObject()
    private lazy var startButton = MenuButton()

    //MARK: - Game Lifecycle
    
    // Начало игры
    private func startGame() {
        viewModel.startGame {
            roadMarksTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self,
                                                  selector: #selector(createRoadMarks), userInfo: nil, repeats: true)
        }
    }
    
    private func stopGame() {
        viewModel.stopGame {
            gameTimer?.invalidate()
            roadMarksTimer?.invalidate()
            // Удаляем все сабвью с вью
            view.subviews.map { $0.removeFromSuperview() }
            presentFinishView()
        }
    }
    
    private func presentFinishView() {
        let animationView = LottieView(lottie: C.Images.Animations.congrats)
        
        animationView.frame = CGRect(x: 0, y: 50, width: view.bounds.width, height: 300)
        animationView.layer.zPosition = -2
        view.addSubview(animationView)
        
        let _ = FinishView(parent: self, 
                                    result: viewModel.getScore(),
                                    width: 200,
                                    height: 200)
    }
    
    
    private func setupPlayer() {
        playerView.setupPlayer(parent: self, 
                               image: viewModel.getVehicleImage(),
                               size: CGSize(width: 60, height: 80),
                               action: #selector(handlePanGesture(_:)))
        playerView.isUserInteractionEnabled = false
    }
    
    
    private func bindScore() {
        viewModel.setNewScore = { [weak self] score in
            self?.scoreCountsLabel.text("\(score)")
        }
    }
    
    //MARK: - SettingUp UI elements
    
    private func configureStartButton() {
        startButton.configure(with: C.Strings.Buttons.start, target: self, action: #selector(startButtonPressed))
        startButton.setColor(color: C.Colors.orange)
    }
    
    private func configScoreLabel() {
        scoreCountsLabel.text("\(0)")
        scoreCountsLabel.backgroundColor = .clear
        scoreCountsLabel.layer.zPosition += 2
    }
    
    //MARK: - Animations
    
    //     Анимация перемещения препятствия
    private func animateObstacle(_ obstacle: UIView) {
        UIView.animate(withDuration: viewModel.getSpeed(), 
                       delay: 0,
                       options: .curveLinear,
                       animations: { [self] in
            obstacle.frame.origin.y = self.view.frame.height + 50
        }, completion: { _ in
            obstacle.removeFromSuperview()
            self.obstacles.removeFirst()
            self.viewModel.increaseScore()
        })
    }

    private func animateRoadMarks(_ roadMark: UIView) {
        UIView.animate(withDuration: viewModel.getSpeed(), 
                       delay: 0,
                       options: .curveLinear,
                       animations: {
            roadMark.frame.origin.y = self.view.frame.height + 50
        }, completion: { _ in
            roadMark.removeFromSuperview()
        })
    }


    //MARK: - @Creating animating views
    
    // Создание препятствия
    @objc private func createObstacle() {
      let obstacle = GameObject(parent: self,
                                size: CGSize(width: 50, height: 50),
                                image: viewModel.getObstacleImage())
      view.addSubview(obstacle)
      obstacles.append(obstacle)
      animateObstacle(obstacle)
    }

    // Создание дорожной разметки
    @objc private func createRoadMarks() {
        let roadMark = GameObject(parent: self,
                                  size: CGSize(width: 10, height: 50))
        view.addSubview(roadMark)
        animateRoadMarks(roadMark)
    }

    //MARK: - @objc UserInteraction methods
    
    @objc private func startButtonPressed() {
        startButton.isUserInteractionEnabled = false
        var leftTillStartTimer : Timer?
        var numberOfSeconds = 3
        leftTillStartTimer = Timer.scheduledTimer(withTimeInterval: Double(1), repeats: true, block: { _ in
            self.startButton.setTitle(title: "\(numberOfSeconds)")
            numberOfSeconds -= 1
                        
        if numberOfSeconds == -1 {
            leftTillStartTimer?.invalidate()
            self.gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self,
                                      selector: #selector(self.createObstacle), userInfo: nil, repeats: true)
            self.playerView.isUserInteractionEnabled = true
            self.startButton.removeFromSuperview()
            }
        })
    }
    
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        playerView.center.x += translation.x
        sender.setTranslation(.zero, in: view)
    }
    
    private func checkForIntersections(with view: UIView) {
        guard let obstaclePresentation = obstacles.first?.layer.presentation() else { return }
        guard !viewModel.isGameOver else { return }
        
        if obstaclePresentation.frame.intersects(view.frame) {
            UIView.animate(withDuration: 0.5) {
                    self.obstacles.first?.backgroundColor = UIColor.green
                    self.obstacles.first?.backgroundColor = UIColor.red
            }
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
                self.stopGame()
            }
            return
        }
    }
    
}




//MARK: - Overridings parent methods


extension GameController {
    
    override func configureView() {
        view.backgroundColor = C.Colors.road
        setupPlayer()
        configureStartButton()
        configScoreLabel()
    }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(playerView)
        view.addSubview(scoreCountsLabel)
        view.addSubview(startButton)
    }
    
    override func layoutConstraints() {
        super.layoutConstraints()
        scoreCountsLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(C.Offsets.mediumOffset)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(C.Offsets.mediumOffset)
            make.width.height.equalTo(50)
        }
        
        startButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
    }
    
    override func startAnimations() {
        super.startAnimations()
        startGame()
        bindScore()
    }
    
    override func stopAnimations() {
        super.stopAnimations()
        stopGame()
    }
}

extension GameController: FinishViewDelegate {
    
    func returnToRootController() {
        viewModel.dismiss()
    }
    
}
