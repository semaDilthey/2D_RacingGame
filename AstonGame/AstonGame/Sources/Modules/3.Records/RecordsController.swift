//
//  RecordsController.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 15.02.2024.
//

import UIKit
import SnapKit

fileprivate enum Constants {
        static var cellHeight : CGFloat = 58
        static var title = "Records pool"
}


final class RecordsController : BaseViewController {
    
    //MARK: - Inizialization
    
    private var viewModel : RecordsVMProtocol
    
    init(viewModel: RecordsVMProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Components
    
    private let animationView = LottieView(lottie: C.Images.Animations.stars)
    private let recordsLabel = UILabel()
    private let tableView = UITableView()
    
    //MARK: - Private methods
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = false
        tableView.backgroundColor = .clear

        tableView.register(RecordsCell.self, forCellReuseIdentifier: RecordsCell.identifier)
    }
    
    private func fetchRecords() {
        DispatchQueue.main.async {
            self.viewModel.fetchRecords()
        }
    }
    
    private func bindTableView() {
        viewModel.reloadTable = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func configureUIComponents() {
        recordsLabel.text = Constants.title
        recordsLabel.font = UIFont.C.rubik(size: .subtitle, type: .title)
        recordsLabel.textColor = C.Colors.nonActive
        
    }
    
    //MARK: - Overriding navBar methods
    
    override func navBarLeftItemHandler() {
        viewModel.dismiss()
    }
}

    //MARK: - Configuring UI

extension RecordsController {
    override func configureView() {
        super.configureView()
        configureTableView()
        fetchRecords()
        bindTableView()
        configureUIComponents()
        addNavBarItem(at: .left(type: .button(image: nil)), title: C.Strings.Buttons.back)
    }
    
    override func addSubviews() {
        view.addSubview(recordsLabel)
        view.addSubview(animationView)
        view.addSubview(tableView)
    }
    
    override func layoutConstraints() {
        
        animationView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(70)
            make.height.equalTo(50)
        }
        
        recordsLabel.snp.makeConstraints { make in
            make.top.equalTo(animationView.snp.bottom).inset(C.Offsets.smallOffset)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(recordsLabel.snp.bottom).offset(C.Offsets.mediumOffset)
            make.leading.equalToSuperview().offset(C.Offsets.bigOffset*2)
            make.trailing.equalToSuperview().inset(C.Offsets.bigOffset*2)
            make.bottom.equalToSuperview().inset(C.Offsets.mediumOffset)
        }
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension RecordsController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecordsCell.identifier) as! RecordsCell
        if let cellModel = viewModel.getModelForCell(at: indexPath) {
            cell.configureCell(at: indexPath.row, model: cellModel)
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.cellHeight
    }
}


