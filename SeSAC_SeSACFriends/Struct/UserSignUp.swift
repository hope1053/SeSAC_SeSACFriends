//
//  UserSignUp.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/22.
//

import Foundation

struct UserSignUp: Codable {
    let phoneNumber: String
    let FCMToken: String
    let nick: String
    let birth: Date
    let email: String
    let gender: Int
}
