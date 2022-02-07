//
//  FriendSeSAC.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/07.
//

import Foundation

// MARK: - FriendSESAC
struct FriendSESAC: Codable {
    // fromQueueDB: 다른 사용자 목록, fromQueueDBRequested: 나에게 요청한 다른 사용자의 목록
    let fromQueueDB, fromQueueDBRequested: [FromQueueDB]
    // fromRecommend: 서비스에서 추천하는 취미 배열
    let fromRecommend: [String]
}

// MARK: - FromQueueDB
struct FromQueueDB: Codable {
    let uid, nick: String
    let lat, long: Double
    // 새싹 타이틀 배열
    let reputation: [Int]
    // hf: 다른 사용자가 하고 싶은 취미, reviews: 다른 사용자의 리뷰 배열
    let hf, reviews: [String]
    let gender, type, sesac, background: Int
}
