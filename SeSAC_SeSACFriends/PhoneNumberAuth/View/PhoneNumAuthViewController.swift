//
//  PhoneNumAuthViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/19.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Toast

class PhoneNumAuthViewController: BaseViewController {
    
    let viewModel = PhoneNumAuthViewModel()
    let disposeBag = DisposeBag()
    var isValid: Bool = false
    var limitTime: Int = 60
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        authNumTextField
            .rx.text
            .orEmpty
            .bind(to: viewModel.authNumObserver)
            .disposed(by: disposeBag)

        viewModel.isAuthNumValid
            .subscribe { valid in
                valid.element! ? self.authorizeButton.fill() : self.authorizeButton.disable()
                self.isValid = valid.element!
            }
            .disposed(by: disposeBag)

        authorizeButton
            .rx.tap
            .subscribe { _ in
                if self.isValid {
                    self.viewModel.requestAuthorization { status in
                        switch status {
                        case .success:
                            let vc = UserNameViewController()
                            self.navigationController?.pushViewController(vc, animated: true)
                        case .error:
                            self.view.makeToast("전화번호 인증 실패", duration: 1.0, position: .bottom)
                        }
                    }
                } else {
                    self.view.makeToast("잘못된 인증 번호 형식입니다", duration: 1.0, position: .bottom)
                }
            }
            .disposed(by: disposeBag)
    }
    
    @objc func setTime() {
        secToTime(sec: limitTime)
        limitTime -= 1
    }
    
    func secToTime(sec: Int) {
        let minute = (sec % 3600) / 60
        let second = (sec % 3600) % 60
        
        if second < 10 {
            timerLabel.text = "0\(minute):0\(second)"
        } else {
            timerLabel.text = "0\(minute):\(second)"
        }
        
        if limitTime != 0 {
            perform(#selector(setTime), with: nil, afterDelay: 1.0)
        } else {
            self.view.makeToast("전화번호 인증 실패", duration: 1.0, position: .bottom)
            sendMsgButton.isEnabled = true
            sendMsgButton.fill()
        }
    }
    
    override func configureView() {
        super.configureView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.view.makeToast("인증 번호를 보냈습니다", duration: 1.0, position: .bottom)
        }
        
        [guideLabel, additionalInfoLabel, authNumTextField, timerLabel, sendMsgButton, authorizeButton].forEach { subView in
            view.addSubview(subView)
        }
        
        authNumTextField.textContentType = .oneTimeCode
        setTime()
        sendMsgButton.isEnabled = false
    }
    
    override func setupConstraints() {
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
