//
//  UserDetailView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/04.
//

import UIKit

class UserDetailView: UIView, BaseView {
        
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    let gender = GenderInfoView()
    let hobby = HobbyInfoView()
    let phoneSearch = PhoneNumSearchView()
    let friendAgeView = FriendAgeView()
    let withdrawView = WithDrawView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        [gender, hobby, phoneSearch, friendAgeView, withdrawView].forEach { subView in
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
