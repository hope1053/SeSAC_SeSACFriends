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
                print("tapped")
                CustomAlertView.shared.showAlert(title: "정말 탈퇴하시겠습니까?", subTitle: "탈퇴하시면 새싹 프렌즈를 이용할 수 없어요ㅠ")
            }
            .disposed(by: disposeBag)
    }
    
    func configureView() {
        self.addSubview(withdrawButton)
    }
    
    func setupConstraints() {
        withdrawButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
//            $0.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
    }
}
