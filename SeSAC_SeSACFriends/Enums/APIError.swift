//
//  APIError.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/21.
//

import Foundation

enum APIError: Error {
    case success
    case notMember
    case FirebaseTokenError
    case serverError
    case forbiddenName
    case alreadyMember
    case alreadyWithdraw
//    case invalidResponse
//    case noData
//    case failed
//    case invalidData
//    case invalidToken
}
