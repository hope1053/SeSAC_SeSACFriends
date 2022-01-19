//
//  MainButton.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/18.
//

import Foundation
import UIKit

enum ButtonStatus {
    case inactive
    case fill
    case outline
    case cancel
    case disable
    // 아이콘 이미지 있는 경우도 추가
    // 폰트가 다른 경우 구분
}

class MainButton: UIButton {
    
    required init(title: String, type: ButtonStatus) {
        super.init(frame: .zero)
        setupButton(title: title, type: type)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButton(title: String, type: ButtonStatus) {
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 8
        
        switch type {
        case .inactive:
            self.backgroundColor = .customWhite
            self.setTitleColor(.customBlack, for: .normal)
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.gray4?.cgColor
            
        case .fill:
            self.backgroundColor = .brandGreen
            self.setTitleColor(.customWhite, for: .normal)
            
        case .outline:
            self.backgroundColor = .customWhite
            self.setTitleColor(.brandGreen, for: .normal)
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.brandGreen?.cgColor
            
        case .cancel:
            self.backgroundColor = .gray2
            self.setTitleColor(.black, for: .normal)
            
        case .disable:
            self.backgroundColor = .gray6
            self.setTitleColor(.gray3, for: .normal)
        }
    }
}
