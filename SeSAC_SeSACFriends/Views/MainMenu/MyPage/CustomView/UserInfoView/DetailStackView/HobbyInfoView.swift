//
//  HobbyInfoView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/04.
//

import UIKit

class HobbyInfoView: UIView, BaseView {
    
    let hobbyLabel: UILabel = {
        let label = UILabel()
        label.text = "자주 하는 취미"
        label.font = .Title4_R14
        label.textColor = .customBlack
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    let hobbyTextField: MainTextFieldView = {
        let textField = MainTextFieldView()
        textField.textField.placeholder = "취미를 입력해주세요"
        return textField
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
        [hobbyLabel, hobbyTextField].forEach { subView in
            stackView.addArrangedSubview(subView)
        }
        
        self.addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        hobbyTextField.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.47)
        }
    }
}
