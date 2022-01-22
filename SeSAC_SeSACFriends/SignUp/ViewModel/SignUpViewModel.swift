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
    
    let userNameObserver = BehaviorRelay<String>(value: "")
    
    var isUserNameValid: Observable<Bool> {
        return userNameObserver.map {
            $0.count >= 1 && $0.count <= 10
        }
    }
}
