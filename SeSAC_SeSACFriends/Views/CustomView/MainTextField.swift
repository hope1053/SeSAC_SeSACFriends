//
//  MainTextField.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/24.
//

import Foundation
import UIKit

class MainTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addLeftPadding()
        self.font = .Title4_R14
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
