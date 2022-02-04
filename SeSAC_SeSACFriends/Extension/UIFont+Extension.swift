//
//  UIFont+Extension.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/18.
//

import UIKit

enum NotoFont: String {
    case medium = "NotoSansKR-Medium"
    case regular = "NotoSansKR-Regular"
}

extension UIFont {
    static let Display1_R20 = UIFont(name: NotoFont.regular.rawValue, size: 20)
    
    static let Title1_M16 = UIFont(name: NotoFont.medium.rawValue, size: 16)
    static let Title2_R16 = UIFont(name: NotoFont.regular.rawValue, size: 16)
    static let Title3_M14 = UIFont(name: NotoFont.medium.rawValue, size: 14)
    static let Title4_R14 = UIFont(name: NotoFont.regular.rawValue, size: 14)
    static let Title5_M12 = UIFont(name: NotoFont.medium.rawValue, size: 12)
    static let Title6_R12 = UIFont(name: NotoFont.regular.rawValue, size: 12)
    
    static let Body1_M16 = UIFont(name: NotoFont.medium.rawValue, size: 16)
    static let Body2_R16 = UIFont(name: NotoFont.regular.rawValue, size: 16)
    static let Body3_R14 = UIFont(name: NotoFont.regular.rawValue, size: 14)
    static let Body4_R12 = UIFont(name: NotoFont.regular.rawValue, size: 12)
    
    static let caption_R10 = UIFont(name: NotoFont.regular.rawValue, size: 10)
}
