//
//  GenderView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/04.
//

import UIKit

class GenderInfoView: UIView, BaseView {
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "내 성별"
        label.font = .Title4_R14
        label.textColor = .customBlack
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    let manButton = MainButton(title: "남자", type: .inactive)
    let womanButton = MainButton(title: "여자", type: .inactive)
    
    let totalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        return stack
    }()
    
    let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 7
        return stack
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
        [manButton, womanButton].forEach { subView in
            buttonStackView.addArrangedSubview(subView)
        }
        
        [genderLabel, buttonStackView].forEach { subView in
            totalStackView.addArrangedSubview(subView)
        }
        
        self.addSubview(totalStackView)
    }
    
    func setupConstraints() {
        totalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.33)
            $0.height.equalTo(buttonStackView.snp.width).multipliedBy(0.4)
        }
    }
    
}
