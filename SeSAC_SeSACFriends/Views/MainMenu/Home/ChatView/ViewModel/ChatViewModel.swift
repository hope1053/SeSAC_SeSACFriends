//
//  ChatViewModel.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/22.
//

import Foundation

import RxSwift
import RxRelay
import RealmSwift
import RxRealm

enum chatCurrentStatus {
    case appointmentCancelled
    case matchingStopped
    case serverError
    case success
}

enum chatSendStatus {
    case success
    case matachingStopped
    case serverError
}

class ChatViewModel {
    
    let inputChatText = BehaviorRelay<String>(value: "")
    var currentTextColorIsBlack: Bool = false
    
    let friendName = BehaviorRelay<String>(value: "")
    
    func sendChat(completion: @escaping (chatSendStatus) -> Void) {
        ChatAPI.sendChat(text: inputChatText.value, uid: User.shared.friendUID.value) { status in
            switch status {
            case .success:
                completion(.success)
            case .matchingStopped:
                completion(.matachingStopped)
            case .serverError:
                completion(.serverError)
            default:
                break
            }
        }
    }
    
    func checkMyStatus(completion: @escaping (chatCurrentStatus) -> Void) {
        QueueAPI.myQueueState { myStateData, status in
            switch status {
            case .success:
                if myStateData?.dodged == 1 || myStateData?.reviewed == 1 {
                    completion(.appointmentCancelled)
                } else if myStateData?.matched == 1 {
                    User.shared.friendUID.accept(myStateData?.matchedUid ?? "")
                    User.shared.friendName.accept(myStateData?.matchedNick ?? "")
//                    self.friendName.accept(myStateData?.matchedNick ?? "")
                }
                completion(.success)
            case .matchingStopped:
                completion(.matchingStopped)
            case .serverError:
                completion(.serverError)
            default:
                break
            }
        }
    }
    
    func lastChatRequest(completion: @escaping () -> Void) {
        
        let localRealm = try! Realm()
        
        let lastChatDate = localRealm.objects(ChatLog.self).last?.sentDate ?? Date.stringToDate("2000-01-01T00:00:00.000Z")
        
        ChatAPI.lastChatRequest(uid: UserInfo.shared.uid ?? "", lastDate: lastChatDate) {
            completion()
        }

    }
}
