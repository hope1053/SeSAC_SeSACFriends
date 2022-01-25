//
//  SignUpViewModel.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/22.
//

import Foundation

import RxSwift
import RxRelay

class SignUpViewModel {
    
    let userBirthObserver = BehaviorRelay<Date>(value: Date())
    
    let userNameObserver = BehaviorRelay<String>(value: "")
//    let userBirthObserver = BehaviorRelay<Date>(value: Date())
    
    var isUserNameValid: Observable<Bool> {
        return userNameObserver.map {
            $0.count >= 1 && $0.count <= 10
        }
    }
    
    var isBirthValid: Observable<Bool> {
        return userBirthObserver.map {
            $0 == Date()
        }
    }
}
