//
//  SocketIOManager.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/22.
//

import Foundation
import SocketIO

import RxSwift
import RealmSwift
import RxRealm

final class SocketIOManager: NSObject {
    
    let localRealm = try! Realm()
    
    let token = UserInfo.shared.idToken ?? ""
    let uid = UserInfo.shared.uid ?? ""
    
    static let shared = SocketIOManager()
    
    // 서버와 메세지를 주고 받기 위한 클래스, 소켓을 연결하고 끊고 관리해주는 객체
    var manager: SocketManager!
    
    // 클라이언트단에서 구현해야하는 기능들을 도와주는 객체
    var socket: SocketIOClient!
    
    override init() {
        super.init()
        
        configureManager()
    }
    
    func configureManager() {
        let url = URL(string: URL.baseURL)!
        
        manager = SocketManager(socketURL: url, config: [
            .log(false),
            .compress,
            .forceWebsockets(true),
            .extraHeaders(["auth" : token])
        ])
        
        socket = manager.defaultSocket
        
        // 소켓 연결될 때 불리는 메서드
        socket.on(clientEvent: .connect) { data, ack in
            print("socket connected", data, ack)
            self.socket.emit("changesocketid", self.uid)
        }
        
        // 소켓 연결 해제될 때 불리는 메서드
        socket.on(clientEvent: .disconnect) { data, ack in
            print("socket disconnected", data, ack)
        }
        
        // Socket으로 들어온 데이터 DB에 저장
        socket.on("chat") { dataArray, ack in
            let data = dataArray[0] as! NSDictionary
            let chat = data["chat"] as! String
            let sender = data["from"] as! String
            let createdAt = data["createdAt"] as! String
            
            let chatLog = ChatLog(sender: sender, chat: chat, sentDate: Date.stringToDate(createdAt))
            
            Observable.from(object: chatLog)
                .subscribe(self.localRealm.rx.add())
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
}
