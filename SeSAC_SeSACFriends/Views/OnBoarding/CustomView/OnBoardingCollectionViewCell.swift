//
//  OnBoardingCollectionViewCell.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/24.
//

import UIKit
import SnapKit

class OnBoardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "OnBoardingCollectionViewCell"
    
    let guideLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "NotoSansKR-Medium", size: 24)
        label.numberOfLines = 0
        label.textColor = UIColor.customBlack
        label.textAlignment = .center
        return label
    }()
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        [guideLabel, imageView].forEach { subView in
            self.addSubview(subView)
        }
    }
    
    func setUpConstraints() {
        guideLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.47)
        }
        
        imageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.96)
            $0.height.equalTo(imageView.snp.width)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(1.3)
        }
    }
}
