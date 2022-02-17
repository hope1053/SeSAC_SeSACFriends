//
//  UserHobbyView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/03.
//

import UIKit

final class UserHobbyView: UIView, BaseView {
    
    let hobbyLabel: UILabel = {
        let label = UILabel()
        label.text = "하고 싶은 취미"
        label.font = .Title6_R12
        label.textColor = .customBlack
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return view
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
        [hobbyLabel, collectionView].forEach { subView in
            self.addSubview(subView)
        }
        
        collectionView.register(HobbyCollectionViewCell.self, forCellWithReuseIdentifier: HobbyCollectionViewCell.identifier)
    }
    
    func setupConstraints() {
        hobbyLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(hobbyLabel.snp.bottom).offset(15)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalToSuperview().inset(15)
        }
    }
    
    
}
