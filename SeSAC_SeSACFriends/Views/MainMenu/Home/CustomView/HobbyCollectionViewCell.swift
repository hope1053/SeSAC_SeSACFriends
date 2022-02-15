//
//  HobbyCollectionViewCell.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/15.
//

import UIKit

class HobbyCollectionViewCell: UICollectionViewCell, BaseView {
    
    static let identifier = "HobbyCollectionViewCell"

    let button: MainButton = {
        let button = MainButton(title: "버튼", type: .inactive)
        button.titleLabel?.font = .Title4_R14
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
        
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }

    func setupConstraints() {
        button.snp.makeConstraints {
            $0.height.equalTo(32)
            $0.edges.equalToSuperview()
        }
    }
}
