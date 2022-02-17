//
//  SearchingFriendViewModel.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/16.
//

import Foundation

import RxSwift
import RxRelay

class SearchingFriendViewModel {
    
    let friendData = BehaviorRelay<FriendSESAC>(value: FriendSESAC(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))
    
    var cellIsSelected: [Bool] = []
    
    func callFriendData(completion: @escaping (APIstatus) -> Void) {
        QueueAPI.onQueue { data, status in
            switch status {
            case .success:
                guard let data = data else { return }
                self.friendData.accept(data)
            case .firebaseTokenError:
                TokenAPI.updateIDToken()
                QueueAPI.onQueue { data, status in
                    guard let data = data else { return }
                    self.friendData.accept(data)
                }
            default:
                completion(status)
            }
        }
    }
    
    func updateArray(_ type: String) {
        if type == "near" {
            cellIsSelected = Array(repeating: false, count: friendData.value.fromQueueDB.count)
        } else {
            cellIsSelected = Array(repeating: false, count: friendData.value.fromQueueDBRequested.count)
        }
    }
}
