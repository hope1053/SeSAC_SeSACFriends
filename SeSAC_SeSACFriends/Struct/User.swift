//
//  User.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/26.
//

import Foundation
import RxSwift
import RxRelay

struct User {
    static let shared = User()
    
    // 핸드폰 인증 후 앱 종료 후 다시 키면 어떻게 처리해야할지
    let phoneNumber = BehaviorRelay<String>(value: "")
    let userName = BehaviorRelay<String>(value: "")
    let birth = BehaviorRelay<Date>(value: Date())
    let email = BehaviorRelay<String>(value: "")
    let gender = BehaviorRelay<Gender>(value: .unknown)
}
