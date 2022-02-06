//
//  UIView+Extension.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/07.
//

import UIKit

extension UIView {
    func addShadow(color: UIColor = UIColor.customBlack!, opacity: Float = 0.4, offset: CGSize = CGSize(width:0, height: 1.5), radius: CGFloat = 2) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
}
