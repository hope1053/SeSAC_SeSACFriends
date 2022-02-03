//
//  UserInfoView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/03.
//

import UIKit

// 사용자 카드뷰
class UserInfoView: UIView, BaseView {
    
    let backgroundImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "sesac_background_1")
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()
    
    let sesacImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "sesac_face_1")
        return image
    }()
    
//    let requestButton: MainButton = {
//        let button = MainButton(title: "요청하기", type: <#T##ButtonStatus#>)
//    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
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
        [backgroundImageView, sesacImageView].forEach { subView in
            self.addSubview(subView)
        }
    }
    
    func setupConstraints() {
        backgroundImageView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        sesacImageView.snp.makeConstraints {
            $0.centerX.equalTo(backgroundImageView).multipliedBy(0.98)
            $0.centerY.equalTo(backgroundImageView).multipliedBy(1.25)
        }
    }
    
    
}
