//
//  SeSACFriendTableViewCell.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/16.
//

import UIKit

class SeSACFriendTableViewCell: UITableViewCell {
    
    var cardView = UserInfoCardView()

    static let identifier = "SeSACFriendTableViewCell"
    
    required init(_ type: CardViewType) {
        super.init(style: .default, reuseIdentifier: nil)
        
        configureView(type)
        setupConstraints()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView(_ type: CardViewType) {
        cardView = UserInfoCardView(cardType: type, reviewType: .noReview)
        
        self.addSubview(cardView)
    }
    
    func setupConstraints() {
        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
