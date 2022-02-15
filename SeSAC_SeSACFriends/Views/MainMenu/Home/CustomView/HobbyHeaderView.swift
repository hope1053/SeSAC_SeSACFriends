//
//  HobbyHeaderView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/15.
//

import UIKit

class HobbyHeaderView: UICollectionReusableView, BaseView {
    
    static let identifier = "HobbyHeaderView"

    let label: UILabel = {
        let label = UILabel()
        label.font = .Title6_R12
        label.textColor = .customBlack
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.backgroundColor = .green
        configureView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.addSubview(label)
    }
    
    func setupConstraints() {
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
