//
//  HobbyView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/15.
//

import UIKit

final class HobbyView: UIView, BaseView {
    
    let collectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return view
    }()
    
    let searchButton = MainButton(title: "새싹 찾기", type: .fill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        [collectionView, searchButton].forEach { subView in
            self.addSubview(subView)
        }
        
        collectionView.register(HobbyHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HobbyHeaderView.identifier)
        collectionView.register(HobbyCollectionViewCell.self, forCellWithReuseIdentifier: HobbyCollectionViewCell.identifier)
    }
    
    func setupConstraints() {
        searchButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(48)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(searchButton.snp.top)
        }
    }
    
    func updateConstraint(_ height: CGFloat) {
        if height == 0 {
            searchButton.layer.cornerRadius = 8
            searchButton.snp.updateConstraints {
                $0.bottom.equalToSuperview()
                $0.leading.trailing.equalToSuperview().inset(16)
            }
        } else {
            searchButton.layer.cornerRadius = 0
            searchButton.snp.updateConstraints {
                let window = UIApplication.shared.windows[0]
                let safeFrame = window.safeAreaLayoutGuide.layoutFrame
                let bottomSafeAreaHeight = window.frame.maxY - safeFrame.maxY
                
                $0.bottom.equalToSuperview().inset(height - bottomSafeAreaHeight)
                $0.leading.trailing.equalToSuperview()
            }
        }
    }
}

final class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
     
     let attributes = super.layoutAttributesForElements(in: rect)
     var leftMargin = sectionInset.left
     var maxY: CGFloat = -1.0
     
     attributes?.forEach { layoutAttribute in
         if layoutAttribute.representedElementCategory == .cell {
             if layoutAttribute.frame.origin.y >= maxY {
               leftMargin = sectionInset.left
             }
             layoutAttribute.frame.origin.x = leftMargin
             leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
             maxY = max(layoutAttribute.frame.maxY, maxY)
         }
     }
     return attributes
 }
}
