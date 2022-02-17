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
    
    let searchable = BehaviorRelay<Int>(value: 0)
    let ageMin = BehaviorRelay<Int>(value: 0)
    let ageMax = BehaviorRelay<Int>(value: 0)
    let hobby = BehaviorRelay<String>(value: "")
    
    // API에 request 넣을 지도상 위치
    let region = BehaviorRelay<Int>(value: 0)
    let lat = BehaviorRelay<Double>(value: 0)
    let long = BehaviorRelay<Double>(value: 0)
    
    let hobbyList = BehaviorRelay<[String]>(value: [])
    let preferGender = 2
    
    let friendUID = BehaviorRelay<String>(value: "")
}

class UserInfo {
    
    static let shared = UserInfo()
    
    var userName: String {
        get {
            UserDefaults.standard.string(forKey: "userName") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userName")
        }
    }
    
    var currentQueueState: queueState {
        get {
            queueState(rawValue: UserDefaults.standard.string(forKey: "currentQueueState") ?? "") ?? .status_default
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "currentQueueState")
        }
    }
}
