//
//  SeSACFriendTableViewCell.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/16.
//

import UIKit

class SeSACFriendRequestCell: UITableViewCell {
    
    var cardView = UserInfoCardView(cardType: .friendRequest, reviewType: .noReview)
    
    var arrowButtonTapHandler: (() -> Void)?

    static let identifier = "SeSACFriendRequestCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.selectionStyle = .none
        self.contentView.addSubview(cardView)
        
        cardView.hobbyView.collectionView.delegate = self
        cardView.hobbyView.collectionView.dataSource = self
        
        cardView.nameView.arrowButton.addTarget(self, action: #selector(arrowButtonClicked), for: .touchUpInside)
    }
    
    func setupConstraints() {
        cardView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    @objc func arrowButtonClicked() {
        arrowButtonTapHandler!()
    }
}

extension SeSACFriendRequestCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HobbyCollectionViewCell.identifier, for: indexPath) as? HobbyCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.button.setTitle("버튼인데용", for: .normal)
        
        return cell
    }
    
    
}
