//
//  SocketIOManager.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/22.
//

import Foundation
import SocketIO

class SocketIOManager: NSObject {
    
    let token = UserInfo.shared.idToken ?? ""
    
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
            .extraHeaders(["auth" : token])
        ])
        
        socket = manager.defaultSocket
        
        // 소켓 연결 요청 메서드(listener) -> 통로를 만드는 과정
        // 통로만 만들었어도 통로가 열려있어서 요청한적이 없어도 계속 데이터가 들어옴
        socket.on(clientEvent: .connect) { data, ack in
            print("socket connected", data, ack)
        }
        
        // 소켓 연결 해제 메서드
        socket.on(clientEvent: .disconnect) { data, ack in
            print("socket disconnected", data, ack)
        }
        
        socket.on("chat") { dataArray, ack in
            print("SESAC RECEIVED", dataArray, ack)
//            let data = dataArray[0] as! NSDictionary
//            let chat = data["text"] as! String
//            let name = data["name"] as! String
//            let createdAt = data["createdAt"] as! String
//
//            print(chat, name, createdAt)
//
//            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: ["chat": chat, "name": name, "createdAt": createdAt])
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
}
