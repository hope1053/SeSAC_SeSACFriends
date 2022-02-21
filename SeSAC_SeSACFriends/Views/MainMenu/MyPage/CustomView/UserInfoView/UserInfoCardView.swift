//
//  UserInfoView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/03.
//

import UIKit

enum CardViewType: String {
    case user
    case friendRequest
    case friendAccept
}

// 사용자 카드뷰
class UserInfoCardView: UIView {
    
    var arrowButtonTapHandler: ((Bool) -> Void)?
    
    var requestAcceptButtonTapHandler: (() -> Void)?

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
    let acceptButton = MainButton(title: "수락하기", type: .acceptRequest)
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.backgroundColor = .customWhite
        stack.layer.cornerRadius = 8
        stack.axis = .vertical
        stack.distribution = .fill
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layer.borderWidth = 1
        stack.layer.borderColor = UIColor.gray2?.cgColor
        return stack
    }()
    
    let nameView = UserNickNameView()
    
    let reputationView: UserReputationView = {
        let view = UserReputationView()
        view.isHidden = true
        return view
    }()
    
    let hobbyView: UserHobbyView = {
        let view = UserHobbyView()
        view.isHidden = true
        return view
    }()
    
    var reviewView = UserReviewView()
    
    required init(cardType: CardViewType, reviewType: ReviewViewType) {
        super.init(frame: .zero)
        configureView(cardType: cardType, reviewType: reviewType)
        setupConstraints(type: cardType)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(cardType: CardViewType, reviewType: ReviewViewType) {
        reviewView = UserReviewView(type: reviewType)
        reviewView.isHidden = true
        
        switch cardType {
        // 내정보 화면에서 사용할 때 (요청하기 버튼, 하고싶은 취미 없는 UI)
        case .user:
            [backgroundImageView, sesacImageView, stackView].forEach { subView in
                self.addSubview(subView)
            }
            [nameView, reputationView, reviewView].forEach { subView in
                stackView.addArrangedSubview(subView)
            }
        // 새싹 찾기 화면에서 사용할 때 (요청하기 버튼, 하고싶은 취미 있는 UI)
        case .friendRequest:
            [backgroundImageView, sesacImageView, requestButton, stackView].forEach { subView in
                self.addSubview(subView)
            }
            [nameView, reputationView, hobbyView, reviewView].forEach { subView in
                stackView.addArrangedSubview(subView)
            }
        case .friendAccept:
            [backgroundImageView, sesacImageView, acceptButton, stackView].forEach { subView in
                self.addSubview(subView)
            }
            [nameView, reputationView, hobbyView, reviewView].forEach { subView in
                stackView.addArrangedSubview(subView)
            }
        }
        
        nameView.arrowButton.addTarget(self, action: #selector(arrowTapped), for: .touchUpInside)
        requestButton.addTarget(self, action: #selector(requestAcceptButtonTapped), for: .touchUpInside)
        acceptButton.addTarget(self, action: #selector(requestAcceptButtonTapped), for: .touchUpInside)
    }
    
    @objc func requestAcceptButtonTapped() {
        if let requestAcceptButtonTapHandler = requestAcceptButtonTapHandler {
            requestAcceptButtonTapHandler()
        }
    }
    
    @objc func arrowTapped(_ button: UIButton) {
        button.isSelected.toggle()
        
        let isSelected = button.isSelected
        
        [reputationView, hobbyView, reviewView].forEach { subView in
            subView.isHidden = !isSelected
        }
        
        if let arrowButtonTapHandler = arrowButtonTapHandler {
            arrowButtonTapHandler(isSelected)
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
            $0.bottom.equalToSuperview()
        }
        
        nameView.snp.makeConstraints {
            $0.height.equalTo(backgroundImageView).multipliedBy(0.25)
        }
        
        reputationView.snp.makeConstraints {
            $0.height.equalTo(backgroundImageView).multipliedBy(0.8)
        }
        
        switch type {
        case .user:
            break
        case .friendRequest:
            hobbyView.snp.makeConstraints {
                $0.height.equalTo(backgroundImageView).multipliedBy(0.4)
            }
            
            requestButton.snp.makeConstraints {
                $0.width.equalToSuperview().multipliedBy(0.2)
                $0.height.equalTo(backgroundImageView.snp.height).multipliedBy(0.2)
                $0.top.equalTo(backgroundImageView.snp.top).offset(12)
                $0.trailing.equalTo(backgroundImageView.snp.trailing).inset(12)
            }
        case .friendAccept:
            hobbyView.snp.makeConstraints {
                $0.height.equalTo(backgroundImageView).multipliedBy(0.4)
            }
            
            acceptButton.snp.makeConstraints {
                $0.width.equalToSuperview().multipliedBy(0.2)
                $0.height.equalTo(backgroundImageView.snp.height).multipliedBy(0.2)
                $0.top.equalTo(backgroundImageView.snp.top).offset(12)
                $0.trailing.equalTo(backgroundImageView.snp.trailing).inset(12)
            }
        }
    }
}
