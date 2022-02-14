//
//  QueueState.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/15.
//

import Foundation

struct QueueState: Codable {
    let dodged, matched, reviewed: Int
    let matchedNick, matchedUid: String?
}
