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
    case alreadyWithdraw
//    case invalidResponse
//    case noData
//    case failed
//    case invalidData
//    case invalidToken
}
