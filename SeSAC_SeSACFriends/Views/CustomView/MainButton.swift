//
//  MainButton.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/18.
//

import UIKit

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
            self.inactive()
            
        case .fill:
            self.fill()
            
        case .outline:
            self.outline()
            
        case .cancel:
            self.cancel()
            
        case .disable:
            self.disable()
        case .canRequest:
            self.canRequest()
        case .alreadyRequested:
            self.alreadyRequested()
        }
    }
}
