//
//  SearchingFriendViewModel.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/16.
//

import Foundation

import RxSwift
import RxRelay

// 싱글톤 사용
class SearchingFriendViewModel {
    
    let friendData = BehaviorRelay<FriendSESAC>(value: FriendSESAC(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))
    
    var nearFriendCount: Int {
        friendData.value.fromQueueDB.count
    }
    
    var requestedFriendCount: Int {
        friendData.value.fromQueueDBRequested.count
    }
    
    var nearFriendData: [FromQueueDB] {
        friendData.value.fromQueueDB
    }

    var requestedFriendData: [FromQueueDB] {
        friendData.value.fromQueueDBRequested
    }
    
    var nearFriendIsSelected: [Bool] = []
    var requestedFriendIsSelected: [Bool] = []
    
    func callFriendData(completion: @escaping (APIstatus) -> Void) {
        QueueAPI.onQueue { data, status in
            switch status {
            case .success:
                guard let data = data else { return }
                
                self.friendData.accept(data)
            case .firebaseTokenError:
                TokenAPI.updateIDToken {
                    QueueAPI.onQueue { data, status in
                        guard let data = data else { return }
                        self.friendData.accept(data)
                    }
                }
            default:
                completion(status)
            }
        }
    }
    
    func updateArray(_ type: String) {
        if type == "near" {
            nearFriendIsSelected = Array(repeating: false, count: friendData.value.fromQueueDB.count)
        } else {
            requestedFriendIsSelected = Array(repeating: false, count: friendData.value.fromQueueDBRequested.count)
        }
    }
    
    func deque(completion: @escaping (String?, DequeueStatus?) -> Void) {
        QueueAPI.dequeue { status in
            switch status {
            case .success:
                completion("새싹 찾기가 중단되었습니다", .success)
            case .alreadyMatched:
                completion("누군가와 취미를 함께하기로 약속하셨어요!", .alreadyMatched)
            case .notMember:
                completion("회원이 아닙니다", nil)
            case .serverError:
                completion("오류가 발생했습니다. 잠시 후에 다시 시도해주세요", nil)
            default:
                break
            }
        }
    }
    
    func updateFriendUID(_ type: String, _ index: Int, completion: @escaping () -> Void) {
        if type == "near" {
            User.shared.friendUID.accept(nearFriendData[index].uid)
        } else {
            User.shared.friendUID.accept(requestedFriendData[index].uid)
        }
        completion()
    }
}
