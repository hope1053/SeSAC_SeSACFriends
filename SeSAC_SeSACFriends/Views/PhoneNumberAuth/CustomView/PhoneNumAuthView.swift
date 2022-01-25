//
//  PhoneNumAuthView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/25.
//

import UIKit

class PhoneNumAuthView: UIView {
    
    let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "인증번호가 문자로 전송되었어요"
        label.textColor = UIColor.customBlack
        label.font = .Display1_R20
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let additionalInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "(최대 소모 20초)"
        label.textColor = .gray7
        label.font = .Title2_R16
        label.textAlignment = .center
        return label
    }()
    
    let authNumTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "인증번호 입력"
        return textField
    }()
    
    let timerLabel: UILabel = {
        let label = UILabel()
        label.text = "01:00"
        label.textColor = .brandGreen
        label.font = .Title3_M14
        return label
    }()
    
    // sendMsgButton 누르면 enabled=false, disable로 다시 변경
    let sendMsgButton: MainButton = {
        let button = MainButton(title: "재전송", type: .disable)
        return button
    }()
    
    let authorizeButton: MainButton = {
        let button = MainButton(title: "인증하고 시작하기", type: .disable)
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
        [guideLabel, additionalInfoLabel, authNumTextField, timerLabel, sendMsgButton, authorizeButton].forEach { subView in
            self.addSubview(subView)
        }
        
        authNumTextField.textContentType = .oneTimeCode
        sendMsgButton.isEnabled = false
    }
    
    func setupConstraints() {
        guideLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.52)
        }
        
        additionalInfoLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(guideLabel.snp.bottom).offset(8)
        }
        
        authNumTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalToSuperview().multipliedBy(0.72)
            $0.centerY.equalToSuperview().multipliedBy(0.85)
            $0.height.equalTo(48)
        }
        
        timerLabel.snp.makeConstraints {
            $0.centerY.equalTo(authNumTextField)
            $0.trailing.equalTo(authNumTextField.snp.trailing).offset(-5)
        }
        
        sendMsgButton.snp.makeConstraints {
            $0.leading.equalTo(authNumTextField.snp.trailing).offset(8)
            $0.bottom.equalTo(authNumTextField.snp.bottom)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
        }
        
        authorizeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(authNumTextField.snp.leading)
            $0.height.equalTo(48)
            $0.centerY.equalToSuperview().multipliedBy(1.1)
        }
    }
    
}
