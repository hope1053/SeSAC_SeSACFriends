//
//  UserReviewView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/03.
//

import UIKit

enum ReviewViewType {
    case noReview
    case oneReview
    case moreThanOneReview
}

class UserReviewView: UIView {
    
    let reviewLabel: UILabel = {
        let label = UILabel()
        label.text = "새싹 리뷰"
        label.font = .Title6_R12
        label.textColor = .customBlack
        return label
    }()
    
    let userReviewLabel: UILabel = {
        let label = UILabel()
        label.text = "첫 리뷰를 기다리는 중이에요!"
        label.textColor = .gray6
        label.font = .Body3_R14
        label.numberOfLines = 0
        return label
    }()
    
    let moreReviewButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "more_arrow"), for: .normal)
        button.isHidden = true
        return button
    }()
    
    required init(type: ReviewViewType) {
        super.init(frame: .zero)
        configureView(type: type)
        setupConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView(type: ReviewViewType) {
        [reviewLabel, userReviewLabel, moreReviewButton].forEach { subView in
            self.addSubview(subView)
        }
        
        switch type {
        case .noReview:
            break
        case .oneReview:
            userReviewLabel.textColor = .customBlack
        case .moreThanOneReview:
            userReviewLabel.textColor = .customBlack
            moreReviewButton.isHidden = false
        }
    }
    
    func setupConstraints() {
        reviewLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        
        userReviewLabel.snp.makeConstraints {
            $0.top.equalTo(reviewLabel.snp.bottom).offset(15)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(15)
        }
        
        moreReviewButton.snp.makeConstraints {
            $0.trailing.top.equalToSuperview()
        }
    }
}
