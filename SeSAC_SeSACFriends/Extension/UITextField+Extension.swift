//
//  UITextField+Extension.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/24.
//

import UIKit

extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
