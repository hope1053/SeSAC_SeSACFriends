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
        self.titleLabel?.font = .Body3_R14
    }
    
    func fill() {
        self.backgroundColor = .brandGreen
        self.setTitleColor(.customWhite, for: .normal)
        self.layer.borderWidth = 0
        self.titleLabel?.font = .Body3_R14
    }
    
    func outline() {
        self.backgroundColor = .customWhite
        self.setTitleColor(.brandGreen, for: .normal)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.brandGreen?.cgColor
        self.titleLabel?.font = .Body3_R14
    }
    
    func cancel() {
        self.backgroundColor = .gray2
        self.setTitleColor(.black, for: .normal)
        self.layer.borderWidth = 0
        self.titleLabel?.font = .Body3_R14
    }
    
    func disable() {
        self.backgroundColor = .gray6
        self.setTitleColor(.gray3, for: .normal)
        self.layer.borderWidth = 0
        self.titleLabel?.font = .Body3_R14
    }
    
    func canRequest() {
        self.backgroundColor = .systemError
        self.setTitleColor(.customWhite, for: .normal)
        self.titleLabel?.font = .Title3_M14
    }
    
    func alreadyRequested() {
        self.backgroundColor = .systemSuccess
        self.setTitleColor(.customWhite, for: .normal)
        self.titleLabel?.font = .Title3_M14
    }
    
    func serverRecommended() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemError?.cgColor
        self.setTitleColor(UIColor.systemError, for: .normal)
    }
    
    func alignTextBelow(spacing: CGFloat = 8.0) {
        guard let image = self.imageView?.image else {
            return
        }

        guard let titleLabel = self.titleLabel else {
            return
        }

        guard let titleText = titleLabel.text else {
            return
        }

        let titleSize = titleText.size(withAttributes: [
            NSAttributedString.Key.font: titleLabel.font as Any
        ])

        titleEdgeInsets = UIEdgeInsets(top: spacing, left: -image.size.width, bottom: -image.size.height, right: 0)
        imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
    }
}
