//
//  PhoneNumSearchView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/04.
//

import UIKit

class PhoneNumSearchView: UIView, BaseView {
    
    let allowPhoneSearchLabel: UILabel = {
        let label = UILabel()
        label.text = "내 번호 검색 허용"
        label.font = .Title4_R14
        label.textColor = .customBlack
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    let isAllowedSwitch: UISwitch = {
        let customSwitch = UISwitch()
        customSwitch.onTintColor = .brandGreen
        return customSwitch
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
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
        [allowPhoneSearchLabel, isAllowedSwitch].forEach { subView in
            stackView.addArrangedSubview(subView)
        }
        
        self.addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
