//
//  ManageInfoView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/03.
//

import UIKit

// 여기에 UserInfoCardView + UserDetailView를 스크롤 위에 올려서 구성하고 ManageInfoViewController에서 self.view로 변경해줄거임
class ManageInfoView: UIView, BaseView {
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.contentInsetAdjustmentBehavior = .never
        return view
    }()
    
    let contentView = UIView()
    
    let cardView = UserInfoCardView(cardType: .user, reviewType: .noReview)
    let userDetailView = UserDetailView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureView() {
        self.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [cardView, userDetailView].forEach { subView in
            contentView.addSubview(subView)
        }

    }

    func setupConstraints() {
        let height = UIScreen.main.bounds.height * 0.45
        
        scrollView.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.centerX.bottom.equalToSuperview()
        }
        
        cardView.snp.makeConstraints {
            $0.top.width.centerX.equalToSuperview()
        }
        
        userDetailView.snp.makeConstraints {
            $0.top.equalTo(cardView.snp.bottom).offset(15)
            $0.width.centerX.equalToSuperview()
            $0.height.equalTo(height)
            $0.bottom.equalToSuperview()
        }
    }
}
