//
//  UserInfo.swift
//  AstonGame
//
//  Created by Семен Гайдамакин on 15.02.2024.
//

import Foundation
import SnapKit
import UIKit

protocol UserDelegate: AnyObject {
    func presentGallery(gallery: UIImagePickerController)
    func dismissGallery(gallery: UIImagePickerController, userImage: PhotoStatus)
    func setUser(name: String?, image: PhotoStatus)
}

enum PhotoStatus {
    case some(UIImage)
    case none
}

private extension String {
    static let placeholder = "Enter ur name"
}

final class UserView : CustomView {
    
    weak var delegate : UserDelegate?
    
    private enum ConstantsUserView {
        static var heightMultiplie : CGFloat = 0.77
    }
    
    private var userImageView = UIImageView()
    private var userNameField = UITextField()
    private lazy var changePhotoButton = UIButton()
    
    var isFilled = false {
        didSet {
            if !isFilled {
                userNameField.layer.borderColor = C.Colors.red.cgColor
            } else {
                
                #warning("Тут намудрил с цветом бордера")
                userNameField.layer.borderColor = C.Colors.nonActive.cgColor
            }
        }
    }
    
    private lazy var imagePicker = UIImagePickerController()
    
    public func configureWithLastPlayer(player: Player?) {
        guard let player else { 
            userImageView.image = C.Images.profileImage
            isFilled = false
            return }
        userNameField.text = player.name
        userImageView.image = player.photo
        isFilled = true
        delegate?.setUser(name: player.name, image: .some(player.photo ?? C.Images.profileImage))
    }
    
    private func setupImageView() {
        userImageView.backgroundColor = .white
        userImageView.layer.cornerRadius = Constants.cornerRadius
        userImageView.layer.borderWidth = C.Offsets.borderWidth
        userImageView.layer.borderColor = C.Colors.nonActive.cgColor
        userImageView.contentMode = .scaleAspectFill
        userImageView.clipsToBounds = true
    }
    
    private func setupNameTextField() {
        userNameField.layer.borderWidth = C.Offsets.borderWidth
        userNameField.layer.borderColor = C.Colors.nonActive.cgColor
        userNameField.backgroundColor = C.Colors.background.withAlphaComponent(0.4)
        userNameField.delegate = self
        userNameField.tintColor = C.Colors.nonActive
        userNameField.inset(size: C.Offsets.mediumOffset)
        userNameField.layer.cornerRadius = Constants.cornerRadius
        userNameField.placeholder = .placeholder
        userNameField.font = UIFont.C.rubik(size: .small, type: .subtitle)
        userNameField.textColor = C.Colors.nonActive
    }
    
    private func setupChangePhotoButton() {
        changePhotoButton.setImage(C.Images.Buttons.changePhoto, for: .normal)
        changePhotoButton.animateTouch(changePhotoButton)
        changePhotoButton.addTarget(self, action: #selector(didTappedEmptyImage), for: .touchUpInside)
    }
    
    private func setupImagePicker() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    
    @objc private func didTappedEmptyImage() {
        delegate?.presentGallery(gallery: imagePicker)
    }
}

extension UserView {
    
    override func configureAppearance() {
        super.configureAppearance()
        
        setupImageView()
        setupNameTextField()
        setupChangePhotoButton()
        setupImagePicker()
    }
    
    override func addViews() {
        super.addViews()
        
        addSubview(userImageView)
        addSubview(userNameField)
        addSubview(changePhotoButton)
    }
    
    override func layoutConstraints() {
        super.layoutConstraints()
        
        userImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(C.Offsets.smallOffset)
            make.leading.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(ConstantsUserView.heightMultiplie)
            make.width.equalTo(snp.height).multipliedBy(ConstantsUserView.heightMultiplie)
        }
        
        changePhotoButton.snp.makeConstraints { make in
            make.leading.equalTo(userImageView.snp.trailing).inset(C.Offsets.mediumOffset)
            make.top.equalTo(userImageView.snp.bottom).inset(C.Offsets.mediumOffset)
            make.height.equalToSuperview().multipliedBy(ConstantsUserView.heightMultiplie/2)
            make.width.equalTo(snp.height).multipliedBy(ConstantsUserView.heightMultiplie/2)
        }
        
        userNameField.snp.makeConstraints { make in
            make.leading.equalTo(userImageView.snp.trailing).offset(C.Offsets.mediumOffset)
            make.top.equalToSuperview().offset(C.Offsets.smallOffset)
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(ConstantsUserView.heightMultiplie)
        }
        
    }
}


extension UserView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameField {
            textField.resignFirstResponder()
            isFilled = true
            delegate?.setUser(name: textField.text, image: .some(userImageView.image ?? C.Images.profileImage))
            if textField.text?.count == 0 {
                isFilled = false
            }
            return true
        }
        return true
    }
    
}

extension UserView : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                userImageView.contentMode = .scaleToFill
                userImageView.image = pickedImage
            delegate?.dismissGallery(gallery: imagePicker, userImage: .some(pickedImage))
            }
    }
}
