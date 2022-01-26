//
//  PhoneNumInputView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/25.
//

import UIKit

class PhoneNumInputView: UIView {
    
    let guideLabel: UILabel = {
        let label = UILabel()
        label.text = """
        새싹 서비스 이용을 위해
        휴대폰 번호를 입력해주세요
        """
        label.font = .Display1_R20
        label.textColor = UIColor.customBlack
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let phoneNumInputView: MainTextFieldView = {
        let view = MainTextFieldView()
        view.textField.placeholder = "휴대폰 번호(-없이 숫자만 입력)"
        view.textField.keyboardType = .numberPad
        return view
    }()
    
    let getAuthNumButton: MainButton = {
        let button = MainButton(title: "인증 문자 받기", type: .disable)
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
        [guideLabel, phoneNumInputView, getAuthNumButton].forEach { subView in
            self.addSubview(subView)
        }
//        phoneNumTextField.delegate = self
    }
    
    func setupConstraints() {
        guideLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.52)
        }
        
        phoneNumInputView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview().multipliedBy(0.85)
            $0.height.equalTo(48)
        }
        
        getAuthNumButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalTo(phoneNumInputView)
            $0.height.equalTo(48)
            $0.centerY.equalToSuperview().multipliedBy(1.1)
        }
    }
    
}
