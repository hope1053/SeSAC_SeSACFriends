//
//  UserGenderView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/25.
//

import UIKit

class UserGenderView: UIView {
    
    let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "성별을 선택해 주세요"
        label.font = .Display1_R20
        label.textColor = UIColor.customBlack
        label.textAlignment = .center
        return label
    }()
    
    let additionalInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "새싹 찾기 기능을 이용하기 위해서 필요해요"
        label.textColor = .gray7
        label.font = .Title2_R16
        label.textAlignment = .center
        return label
    }()
    
    let manButton: MainButton = {
        let button = MainButton(title: "남자", type: .inactive)
        button.setImage(UIImage(named: "man"), for: .normal)
        button.alignTextBelow()
        return button
    }()
    
    let womanButton: MainButton = {
        let button = MainButton(title: "여자", type: .inactive)
        button.setImage(UIImage(named: "woman"), for: .normal)
        button.alignTextBelow()
        return button
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    let nextButton: MainButton = {
        let button = MainButton(title: "다음", type: .disable)
        return button
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
            stackView.addArrangedSubview(subView)
        }
        
        [guideLabel, additionalInfoLabel, stackView , nextButton].forEach { subView in
            self.addSubview(subView)
        }
    }
    
    func setupConstraints() {
        
        guideLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.52)
        }
        
        additionalInfoLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(guideLabel.snp.bottom).offset(8)
            $0.height.equalTo(30)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(additionalInfoLabel.snp.bottom).offset(32)
            $0.bottom.equalTo(nextButton.snp.top).offset(-32)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
            $0.centerY.equalToSuperview().multipliedBy(1.1)
        }
    }
    
}

