//
//  RealmModel.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/23.
//

import Foundation

import RealmSwift

class ChatLog: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var sender: String // 보낸 사람의 uid
    @Persisted var chat: String // 내용
    @Persisted var sentDate = Date() // 날짜
//    @Persisted var sentDate: String // 날짜
    
    convenience init(sender: String, chat:String, sentDate: Date) {
        self.init()
        
        self.sender = sender
        self.chat = chat
        self.sentDate = sentDate
    }
}
