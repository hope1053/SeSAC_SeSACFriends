//
//  ChatViewModel.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/22.
//

import Foundation

import RxSwift
import RxRelay

enum chatCurrentStatus {
    case appointmentCancelled
    case matchingStopped
    case serverError
}

enum chatSendStatus {
    case success
    case matachingStopped
    case serverError
}

class ChatViewModel {
    
    let inputChatText = BehaviorRelay<String>(value: "")
    var currentTextColorIsBlack: Bool = false
    
    var friendUID: String = ""
    let friendName = BehaviorRelay<String>(value: "")
    
    func sendChat(completion: @escaping (chatSendStatus) -> Void) {
        ChatAPI.sendChat(text: inputChatText.value, uid: friendUID) { status in
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
                    self.friendUID = myStateData?.matchedUid ?? ""
                    self.friendName.accept(myStateData?.matchedNick ?? "")
                }
            case .matchingStopped:
                completion(.matchingStopped)
            case .serverError:
                completion(.serverError)
            default:
                break
            }
        }
    }
}
