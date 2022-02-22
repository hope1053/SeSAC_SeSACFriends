//
//  Chat.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/22.
//

import Foundation

// MARK: - Chat
struct Chat: Codable {
    let id: String
    let v: Int
    let to, from, chat, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case v = "__v"
        case to, from, chat, createdAt
    }
}
