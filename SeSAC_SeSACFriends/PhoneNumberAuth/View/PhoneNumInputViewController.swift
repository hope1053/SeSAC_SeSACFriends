//
//  PhoneNumberInputViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/19.
//

import UIKit

class PhoneNumInputViewController: BaseViewController {

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
    
    let phoneNumTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "휴대폰 번호(-없이 숫자만 입력)"
        return textField
    }()
    
    let getAuthNumButton: MainButton = {
        let button = MainButton(title: "인증 문자 받기", type: .disable)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configureView() {
        super.configureView()
        [guideLabel, phoneNumTextField, getAuthNumButton].forEach { subView in
            view.addSubview(subView)
        }
    }
    
    override func setupConstraints() {
        guideLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.52)
        }
        
        phoneNumTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview().multipliedBy(0.85)
            $0.height.equalTo(48)
        }
        
        getAuthNumButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.trailing.equalTo(phoneNumTextField)
            $0.height.equalTo(48)
            $0.centerY.equalToSuperview().multipliedBy(1.1)
        }
    }
    

}
