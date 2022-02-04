//
//  WithDrawView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/04.
//

import UIKit

class WithDrawView: UIView, BaseView {
    
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.addSubview(withdrawButton)
    }
    
    func setupConstraints() {
        withdrawButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
