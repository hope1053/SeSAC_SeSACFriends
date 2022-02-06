//
//  CustomAlertViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/05.
//

import UIKit

import RxSwift
import RxCocoa

class CustomAlertView: UIView, BaseView {
    
    let disposeBag = DisposeBag()
    
    static let shared = CustomAlertView()
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .customBlack!.withAlphaComponent(0.5)
        return view
    }()
    
    let messageView: UIView = {
        let view = UIView()
        view.backgroundColor = .customWhite
        view.layer.cornerRadius = 16
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Body1_M16
        label.textColor = .customBlack
        label.textAlignment = .center
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Title4_R14
        label.textColor = .customBlack
        label.textAlignment = .center
        return label
    }()
    
    let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
    
    let cancelButton: MainButton = MainButton(title: "취소", type: .cancel)
    let okButton: MainButton = MainButton(title: "확인", type: .fill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setupConstraints()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.addSubview(bgView)
        bgView.addSubview(messageView)
        
        [titleLabel, subTitleLabel, buttonStackView].forEach { subView in
            messageView.addSubview(subView)
        }
        
        [cancelButton, okButton].forEach { subView in
            buttonStackView.addArrangedSubview(subView)
        }
    }
    
    func setupConstraints() {
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        bgView.snp.makeConstraints {
            $0.width.equalTo(screenWidth)
            $0.height.equalTo(screenHeight)
            $0.leading.top.equalToSuperview()
        }
        
        messageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.18)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(15)
            $0.top.equalToSuperview().inset(15)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(subTitleLabel)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(15)
            $0.height.equalTo(messageView.snp.height).multipliedBy(0.3)
            $0.bottom.equalToSuperview().inset(15)
        }
    }
    
    func showAlert(title: String, subTitle: String) {
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
        
        UIApplication.shared.keyWindow?.addSubview(bgView)
    }
    
    func bind() {
        cancelButton
            .rx.tap
            .bind { _ in
                self.bgView.removeFromSuperview()
            }
            .disposed(by: disposeBag)
    }
}
