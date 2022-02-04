//
//  UserNameView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/03.
//

import UIKit

class UserNickNameView: UIView, BaseView {
    
    let userNickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "고래밥"
        return label
    }()
    
    let arrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "down"), for: .normal)
        button.setImage(UIImage(named: "up"), for: .selected)
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
        [userNickNameLabel, arrowButton].forEach { subView in
            self.addSubview(subView)
        }
        
//        arrowButton.addTarget(self, action: #selector(arrowTapped), for: .touchUpInside)
    }
    
    func setupConstraints() {
        userNickNameLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.top.leading.bottom.equalToSuperview()
        }
        
        arrowButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.1)
            $0.top.trailing.bottom.equalToSuperview()
        }
    }
    
//    @objc func arrowTapped(_ button: UIButton) {
//        button.isSelected = !button.isSelected
//    }
    
}
