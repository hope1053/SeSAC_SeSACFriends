//
//  HobbyCollectionViewCell.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/15.
//

import UIKit

final class HobbyCollectionViewCell: UICollectionViewCell, BaseView {
    
    static let identifier = "HobbyCollectionViewCell"

    let button: MainButton = {
        let button = MainButton(title: "버튼", type: .inactive)
        button.titleLabel?.font = .Title4_R14
        button.isUserInteractionEnabled = false
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
        self.addSubview(button)
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10)
    }

    func setupConstraints() {
        self.snp.makeConstraints {
            $0.height.equalTo(32)
        }
        
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
