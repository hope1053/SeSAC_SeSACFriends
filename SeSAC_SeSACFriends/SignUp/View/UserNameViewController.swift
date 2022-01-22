//
//  UserNameViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/21.
//

import UIKit

import RxCocoa
import RxSwift
import Toast

class UserNameViewController: BaseViewController {
    
    let viewModel = SignUpViewModel()
    let disposeBag = DisposeBag()
    var isValid = false
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        userNameTextField
            .rx.text
            .orEmpty
            .bind(to: viewModel.userNameObserver)
            .disposed(by: disposeBag)
        
        viewModel.isUserNameValid
            .subscribe { isValid in
                isValid.element! ? self.nextButton.fill() : self.nextButton.disable()
                self.isValid = isValid.element!
            }
            .disposed(by: disposeBag)
        
        nextButton
            .rx.tap
            .subscribe { _ in
                if self.isValid {
                    let vc = UserBirthViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.view.makeToast("닉네임은 1자 이상 10자 이내로 부탁드려요.", duration: 1.0, position: .bottom)
                }
            }
            .disposed(by: disposeBag)
    }
    
    override func configureView() {
        super.configureView()
        userNameTextField.becomeFirstResponder()
        [guideLabel, userNameTextField, nextButton].forEach { subView in
            view.addSubview(subView)
        }
    }
    
    override func setupConstraints() {
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
