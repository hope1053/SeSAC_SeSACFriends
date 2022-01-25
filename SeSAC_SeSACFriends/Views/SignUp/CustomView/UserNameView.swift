//
//  UserNameView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/25.
//

import UIKit

class UserNameView: UIView {
    
    let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임을 입력해주세요"
        label.font = .Display1_R20
        label.textColor = UIColor.customBlack
        label.textAlignment = .center
        return label
    }()
    
    let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "10자 이내로 입력"
        return textField
    }()
    
    let nextButton: MainButton = {
        let button = MainButton(title: "다음", type: .disable)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        userNameTextField.becomeFirstResponder()
        [guideLabel, userNameTextField, nextButton].forEach { subView in
            self.addSubview(subView)
        }
    }
    
    func setupConstraints() {
        guideLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.52)
        }
        
        userNameTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview().multipliedBy(0.85)
            $0.height.equalTo(48)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalTo(userNameTextField)
            $0.height.equalTo(48)
            $0.centerY.equalToSuperview().multipliedBy(1.1)
        }
    }
    
}
