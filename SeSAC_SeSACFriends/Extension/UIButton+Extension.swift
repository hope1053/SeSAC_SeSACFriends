//
//  UIButton+Extension.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/19.
//

import Foundation
import UIKit

extension UIButton {
    func inactive() {
        self.backgroundColor = .customWhite
        self.setTitleColor(.customBlack, for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray4?.cgColor
    }
    
    func fill() {
        self.backgroundColor = .brandGreen
        self.setTitleColor(.customWhite, for: .normal)
        self.layer.borderWidth = 0
    }
    
    func outline() {
        self.backgroundColor = .customWhite
        self.setTitleColor(.brandGreen, for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.brandGreen?.cgColor
    }
    
    func cancel() {
        self.backgroundColor = .gray2
        self.setTitleColor(.black, for: .normal)
        self.layer.borderWidth = 0
    }
    
    func disable() {
        self.backgroundColor = .gray6
        self.setTitleColor(.gray3, for: .normal)
        self.layer.borderWidth = 0
    }
    
    func showIcon() {
        
    }
}
