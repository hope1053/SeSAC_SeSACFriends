//
//  PhoneNumAuthViewModel.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/20.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class PhoneNumAuthViewModel {
    
    let phoneNumObserver = BehaviorRelay<String>(value: "")
    
    var isValid: Observable<Bool> {
        return phoneNumObserver
            .map { phoneNum in
                print("phoneNum: \(phoneNum)")
                return self.validatePhoneNum(phoneNum: phoneNum)
            }
    }
    
    // 유효성검사 메서드
    func validatePhoneNum(phoneNum: String) -> Bool {
        let checkPattern = "^01([0-9])([0-9]{4})([0-9]{4})$"
        let regex = try? NSRegularExpression(pattern: checkPattern)

        if let _ = regex?.firstMatch(in: phoneNum, options: [], range: NSRange(location: 0, length: phoneNum.count)) {
            return true
        }
        return false
    }
}
