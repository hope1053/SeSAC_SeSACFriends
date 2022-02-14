//
//  WithDrawView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/04.
//

import UIKit

import RxSwift
import RxCocoa

class WithDrawView: UIView, BaseView {
    
    let disposeBag = DisposeBag()
    
    let withDrawView = CustomAlertView()
    
    let withdrawButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원탈퇴", for: .normal)
        button.setTitleColor(.customBlack, for: .normal)
        button.titleLabel?.font = .Title4_R14
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setupConstraints()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind() {
        withdrawButton
            .rx.tap
            .bind { _ in
                self.withDrawView.showAlert(title: "정말 탈퇴하시겠습니까?", subTitle: "탈퇴하시면 새싹 프렌즈를 이용할 수 없어요ㅠ")
            }
            .disposed(by: disposeBag)
        
        withDrawView.okButton
            .rx.tap
            .bind { _ in
                UserAPI.withdraw { error in
                    switch error {
                    case .success:
                        let onboardingView = OnBoardingViewController()
                        let sd = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                        sd?.window?.rootViewController = onboardingView
                    case .alreadyWithdraw:
                        self.makeToast("이미 탈퇴된 회원", duration: 1.0, position: .bottom)
                    case .serverError:
                        self.makeToast("에러가 발생했습니다. 잠시 후 다시 시도해주세요", duration: 1.0, position: .bottom)
                    default:
                        self.makeToast("에러가 발생했습니다. 잠시 후 다시 시도해주세요", duration: 1.0, position: .bottom)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    func configureView() {
        self.addSubview(withdrawButton)
    }
    
    func setupConstraints() {
        withdrawButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
}
