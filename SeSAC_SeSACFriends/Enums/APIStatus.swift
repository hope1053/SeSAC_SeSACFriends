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
}

enum APIstatus: Int {
    case success = 200
    case firebaseTokenError = 401
    case notMember = 406
    case serverError = 500
    case clientError = 501
}

enum MyQueueStatus: Int {
    case success = 200
    case matchingStopped = 201
    case firebaseTokenError = 401
    case notMember = 406
    case serverError = 500
    case clientError = 501
}

enum QueueStatus: Int {
    case success = 200
    case reportMoreThenThreeTimes = 201
    case penaltyLevel1 = 203
    case penaltyLevel2 = 204
    case penaltyLevel3 = 205
    case genderNotSelected = 206
    case firebaseTokenError = 401
    case notMember = 406
    case serverError = 500
    case clientError = 501
}

enum DequeueStatus: Int {
    case success = 200
    case alreadyMatched = 201
    case firebaseTokenError = 401
    case notMember = 406
    case serverError = 500
}
