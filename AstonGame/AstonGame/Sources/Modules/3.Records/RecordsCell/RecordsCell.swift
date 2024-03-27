//
//  RecordsCell.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 21.02.2024.
//

import Foundation
import SnapKit
import UIKit

private extension String {
    static let identifier = "RecordsCell"
}

final class RecordsCell : UITableViewCell {
    
    static let identifier : String = .identifier
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureAppearance()
        addSubviews()
        layoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        containerView.prepareForReuse()
    }
    
    private var containerView = RecordsCellContentView()
    
    public func configureCell(at indexPath: Int, model: RecordsCellModel) {
        let cellView = RecordsCellContentView()
        cellView.configureView(with: model)
        setCellView(view: cellView)
        setRoundedCorner(for: indexPath)
        setContainerColor(for: indexPath)
    }
    
    private func setCellView(view: UIView) {
        containerView.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setContainerColor(for indexPath: Int) {
        if indexPath % 2 == 1 {
            containerView.backgroundColor = .blue.withAlphaComponent(0.3)
        } else {
            containerView.backgroundColor = .blue.withAlphaComponent(0.2)
        }
    }
    
    private func setRoundedCorner(for indexPath: Int) {
        if indexPath == 0 {
            containerView.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: C.Offsets.cornerRadius)
        }
        if indexPath == 9 {
            backgroundColor = .clear
            containerView.roundCorners(corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: C.Offsets.cornerRadius)
        }
    }
}

extension RecordsCell {
    
    private func configureAppearance() {
        isUserInteractionEnabled = false
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
    }
    
    private func layoutConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
