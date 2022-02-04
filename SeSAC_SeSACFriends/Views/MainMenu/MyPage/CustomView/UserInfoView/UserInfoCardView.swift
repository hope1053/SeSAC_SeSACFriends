//
//  UserInfoView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/03.
//

import UIKit

enum CardViewType: String {
    case user
    case friend
}

// 사용자 카드뷰
class UserInfoCardView: UIView {

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
    
    let requestButton = MainButton(title: "요청하기", type: .canRequest)
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .customWhite
        stack.layer.cornerRadius = 8
        stack.axis = .vertical
        stack.distribution = .fill
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    let nameView = UserNickNameView()
    let reputationView = UserReputationView()
    let hobbyView = UserHobbyView()
    let reviewView = UserReviewView()
    
    required init(type: CardViewType) {
        super.init(frame: .zero)
        configureView(type: type)
        setupConstraints(type: type)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(type: CardViewType) {
        switch type {
        // 내정보 화면에서 사용할 때 (요청하기 버튼, 하고싶은 취미 없는 UI)
        case .user:
            [backgroundImageView, sesacImageView, stackView].forEach { subView in
                self.addSubview(subView)
            }
            [nameView, reputationView, reviewView].forEach { subView in
                stackView.addArrangedSubview(subView)
            }
        // 새싹 찾기 화면에서 사용할 때 (요청하기 버튼, 하고싶은 취미 있는 UI)
        case .friend:
            [backgroundImageView, sesacImageView, requestButton, stackView].forEach { subView in
                self.addSubview(subView)
            }
            [nameView, reputationView, hobbyView, reviewView].forEach { subView in
                stackView.addArrangedSubview(subView)
            }
        }
    }
    
    func setupConstraints(type: CardViewType) {
        backgroundImageView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.height.equalTo(200)
        }
        
        sesacImageView.snp.makeConstraints {
            $0.centerX.equalTo(backgroundImageView).multipliedBy(0.98)
            $0.centerY.equalTo(backgroundImageView).multipliedBy(1.25)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(backgroundImageView)
            $0.top.equalTo(backgroundImageView.snp.bottom)
//            $0.height.equalTo(200)
        }
        
        nameView.snp.makeConstraints {
            $0.height.equalTo(backgroundImageView).multipliedBy(0.25)
            $0.bottom.equalToSuperview()
        }
        
        switch type {
        case .user:
            break
        case .friend:
            requestButton.snp.makeConstraints {
                $0.width.equalToSuperview().multipliedBy(0.2)
                $0.height.equalTo(backgroundImageView.snp.height).multipliedBy(0.2)
                $0.top.equalTo(backgroundImageView.snp.top).offset(12)
                $0.trailing.equalTo(backgroundImageView.snp.trailing).inset(12)
            }
        }
    }
}