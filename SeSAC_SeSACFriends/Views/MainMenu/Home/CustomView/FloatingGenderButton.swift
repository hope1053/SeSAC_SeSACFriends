//
//  FloatingGenderButton.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/06.
//

import UIKit

class FloatingGenderButton: UIView, BaseView {
    
    let totalButton: MainButton = {
        let button = MainButton(title: "전체", type: .inactive)
        button.layer.cornerRadius = 0
        button.layer.borderWidth = 0
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return button
    }()
    
    let manButton: MainButton = {
        let button = MainButton(title: "남자", type: .inactive)
        button.layer.cornerRadius = 0
        button.layer.borderWidth = 0
        return button
    }()
    
    let womanButton: MainButton = {
        let button = MainButton(title: "여자", type: .inactive)
        button.layer.cornerRadius = 0
        button.layer.borderWidth = 0
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        return button
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.addShadow()
        return stack
    }()
    
    let updateLocationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .customWhite
        button.setImage(UIImage(named: "place"), for: .normal)
        button.layer.cornerRadius = 8
        button.addShadow()
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
        self.addSubview(stackView)
        self.addSubview(updateLocationButton)
        
        [totalButton, manButton, womanButton].forEach { subView in
            stackView.addArrangedSubview(subView)
        }
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()

        }
        
        updateLocationButton.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(20)
            $0.trailing.leading.equalTo(stackView)
            $0.height.equalTo(updateLocationButton.snp.width)
            $0.bottom.equalToSuperview()
        }
    }
}
