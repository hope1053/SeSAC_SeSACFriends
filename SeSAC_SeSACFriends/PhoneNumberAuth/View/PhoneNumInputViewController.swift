//
//  PhoneNumberInputViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/19.
//

import UIKit
import RxSwift
import RxCocoa
import Toast

// 사용자가 텍스트 필드에 숫자 입력
// 유효성 체크를 계속 업데이트
// 유효성 체크를 만족시키면 버튼 상태도 업데이트

class PhoneNumInputViewController: BaseViewController {
    
    let viewModel = PhoneNumAuthViewModel()
    let disposeBag = DisposeBag()
    var isValid: Bool = false

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
        bind()
    }
    
    func bind() {
        
        phoneNumTextField
            .rx.text
            .orEmpty
            .bind(to: viewModel.phoneNumObserver)
            .disposed(by: disposeBag)
        
        viewModel.isValid
            .subscribe { valid in
                valid.element! ? self.getAuthNumButton.fill() : self.getAuthNumButton.disable()
                self.isValid = valid.element!
            }
            .disposed(by: disposeBag)
        
        getAuthNumButton
            .rx.tap
            .subscribe { _ in
                if self.isValid {
                    let vc = PhoneNumAuthViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.view.makeToast("잘못된 전화번호 형식입니다", duration: 1.0, position: .bottom)
                }
            }
            .disposed(by: disposeBag)
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
