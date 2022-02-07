//
//  APIError.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/21.
//

import Foundation

enum APIStatus: String {
    case success
    case notMember
    case serverError
    case forbiddenName
    case alreadyMember
//    case firebaseTokenError
    case alreadyWithdraw
//    case alreadyWithdraw =
//    case invalidResponse
//    case noData
//    case failed
//    case invalidData
//    case invalidToken
}

enum APIstatus: Int {
    case success = 200
    case firebaseTokenError = 401
    case notMember = 406
    case serverError = 500
    case clientError = 501
}
