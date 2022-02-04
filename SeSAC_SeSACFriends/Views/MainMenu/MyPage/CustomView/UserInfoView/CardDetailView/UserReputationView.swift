//
//  UserReputationView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/03.
//

import UIKit

class UserReputationView: UIView, BaseView {
    
    let sesacTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "새싹 타이틀"
        label.font = .Title6_R12
        label.textColor = .customBlack
        return label
    }()
    
    let firstVerticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 6
        return stack
    }()
    
    let secondVerticalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 6
        return stack
    }()
    
    let horizontalStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 6
        return stack
    }()
    
    let goodManerButton = MainButton(title: "좋은 매너", type: .inactive)
    let accurateTimeButton = MainButton(title: "정확한 시간 약속", type: .inactive)
    let quickReplyButton = MainButton(title: "빠른 응답", type: .inactive)
    let nicePersonalityButton = MainButton(title: "친절한 성격", type: .inactive)
    let goodSkillButton = MainButton(title: "능숙한 취미 실력", type: .inactive)
    let goodTimeButton = MainButton(title: "유익한 시간", type: .inactive)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        [sesacTitleLabel, horizontalStackView].forEach { subView in
            self.addSubview(subView)
        }
        
        [firstVerticalStackView, secondVerticalStackView].forEach { subView in
            horizontalStackView.addArrangedSubview(subView)
        }
        
        [goodManerButton, quickReplyButton, goodSkillButton].forEach { subView in
            firstVerticalStackView.addArrangedSubview(subView)
        }
        
        [accurateTimeButton, nicePersonalityButton, goodTimeButton].forEach { subView in
            secondVerticalStackView.addArrangedSubview(subView)
        }
    }
    
    func setupConstraints() {
        sesacTitleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        
        horizontalStackView.snp.makeConstraints {
            $0.top.equalTo(sesacTitleLabel.snp.bottom).offset(15)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(15)
        }
    }
}
