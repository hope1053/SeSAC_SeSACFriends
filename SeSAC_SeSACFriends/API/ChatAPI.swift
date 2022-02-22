//
//  ChatAPI.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/22.
//

import Foundation

import Alamofire
import RxSwift
import RealmSwift
import RxRealm
import SwiftyJSON

class ChatAPI {
    
    static var header: HTTPHeaders {
        [
            "Content-Type": "application/x-www-form-urlencoded",
            "idtoken": UserInfo.shared.idToken ?? ""
        ]
    }
    
    static func sendChat(text: String, uid: String, completion: @escaping (MyQueueStatus) -> Void) {
        
        let localRealm = try! Realm()
        
        let parameter: [String: Any] = [
            "chat": text
        ]
        
        AF.request(Endpoint.sendChat(uid: uid).url, method: .post, parameters: parameter, headers: header).validate().response { response in
            let statusCode = response.response?.statusCode ?? 500
            let APIStatus = MyQueueStatus(rawValue: statusCode)!
            
            switch APIStatus {
            case .success:
                // 응답값을 DB에 저장하라고...? 네..
                let data = JSON(response.value)
                
                let sentDate = Date.stringToDate(data["createdAt"].stringValue)
                let chatLog = ChatLog(sender: data["from"].stringValue, chat: data["chat"].stringValue, sentDate: sentDate)
                
                Observable.from(object: chatLog)
                    .subscribe(localRealm.rx.add())
                
                completion(.success)
            case .firebaseTokenError:
                TokenAPI.updateIDToken {
                    sendChat(text: text, uid: uid) { status in
                        switch APIStatus {
                        case .success:
                            // 응답값 DB 저장
                            let data = JSON(response.value)
                            
                            let sentDate = Date.stringToDate(data["createdAt"].stringValue)
                            let chatLog = ChatLog(sender: data["from"].stringValue, chat: data["chat"].stringValue, sentDate: sentDate)
                            
                            Observable.from(object: chatLog)
                                .subscribe(localRealm.rx.add())
                            
                            completion(.success)
                        default:
                            completion(status)
                        }
                    }
                }
            default:
                completion(APIStatus)
            }
        }
    }
    
    static func lastChatRequest(uid: String, lastDate: Date, completion: @escaping (APIstatus) -> Void) {
        
        let localRealm = try! Realm()
        
        AF.request(Endpoint.lastChat(uid: uid, lastDate: lastDate).url, method: .get, headers: header).validate().response { response in
            let statusCode = response.response?.statusCode ?? 500
            let APIStatus = APIstatus(rawValue: statusCode)!
            
            switch APIStatus {
            case .success:
                let data = JSON(response.value)
                
                var chatLogList: [ChatLog] = []
                
                data["payload"].arrayValue.forEach { chatData in
                    let sentDate = Date.stringToDate(data["createdAt"].stringValue)
                    let chatLog = ChatLog(sender: data["from"].stringValue, chat: data["chat"].stringValue, sentDate: sentDate)
                    
                    chatLogList.append(chatLog)
                }
                
                Observable.from(chatLogList)
                    .subscribe(localRealm.rx.add())
                
            case .firebaseTokenError:
                TokenAPI.updateIDToken {
                    let data = JSON(response.value)
                    
                    var chatLogList: [ChatLog] = []
                    
                    data["payload"].arrayValue.forEach { chatData in
                        let sentDate = Date.stringToDate(data["createdAt"].stringValue)
                        let chatLog = ChatLog(sender: data["from"].stringValue, chat: data["chat"].stringValue, sentDate: sentDate)
                        
                        chatLogList.append(chatLog)
                    }
                    
                    Observable.from(chatLogList)
                        .subscribe(localRealm.rx.add())
                }
            default:
                completion(APIStatus)
            }
        }
    }
}
