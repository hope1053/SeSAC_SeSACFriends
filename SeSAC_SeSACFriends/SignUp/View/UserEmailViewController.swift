//
//  UserEmailViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/22.
//

import UIKit

import RxCocoa
import RxSwift

class UserEmailViewController: BaseViewController {
    
    let viewModel = SignUpViewModel()
    let disposeBag = DisposeBag()
    var isValid = false
    
    let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일을 입력해주세요"
        label.font = .Display1_R20
        label.textColor = UIColor.customBlack
        label.textAlignment = .center
        return label
    }()
    
    let additionalInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "휴대폰 번호 변경 시 인증을 위해 사용해요"
        label.textColor = .gray7
        label.font = .Title2_R16
        label.textAlignment = .center
        return label
    }()
    
    let userEmailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "SeSAC@email.com"
        return textField
    }()
    
    let nextButton: MainButton = {
        let button = MainButton(title: "다음", type: .disable)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
//        userEmailTextField
//            .rx.text
//            .orEmpty
//            .bind(to: viewModel.userNameObserver)
//            .disposed(by: disposeBag)
//
//        viewModel.isUserNameValid
//            .subscribe { isValid in
//                isValid.element! ? self.nextButton.fill() : self.nextButton.disable()
//                self.isValid = isValid.element!
//            }
//            .disposed(by: disposeBag)

        nextButton
            .rx.tap
            .subscribe { _ in
                let vc = UserGenderViewController()
                self.navigationController?.pushViewController(vc, animated: true)
//                if self.isValid {
//                    let vc = UserBirthViewController()
//                    self.navigationController?.pushViewController(vc, animated: true)
//                } else {
//                    self.view.makeToast("닉네임은 1자 이상 10자 이내로 부탁드려요.", duration: 1.0, position: .bottom)
//                }
            }
            .disposed(by: disposeBag)
    }
    
    override func configureView() {
        super.configureView()
        userEmailTextField.becomeFirstResponder()
        [guideLabel, additionalInfoLabel, userEmailTextField, nextButton].forEach { subView in
            view.addSubview(subView)
        }
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
        
        userEmailTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.width.equalToSuperview().multipliedBy(0.72)
            $0.centerY.equalToSuperview().multipliedBy(0.85)
            $0.height.equalTo(48)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(userEmailTextField.snp.leading)
            $0.height.equalTo(48)
            $0.centerY.equalToSuperview().multipliedBy(1.1)
        }
    }
}
