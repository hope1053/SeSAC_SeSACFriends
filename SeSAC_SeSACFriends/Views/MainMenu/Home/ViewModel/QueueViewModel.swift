//
//  QueueViewModel.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/07.
//

import Foundation
import CoreLocation
import RxRelay

class QueueViewModel {
    
    let user = User.shared
    
    let friendData = BehaviorRelay<FriendSESAC>(value: FriendSESAC(fromQueueDB: [], fromQueueDBRequested: [], fromRecommend: []))
    let hobbyFromServer = BehaviorRelay<([String], [String])>(value: ([], []))
    let totalHobby = BehaviorRelay<[String]>(value: [])
//    let myHobby = BehaviorRelay<[String]>(value: [])
    
    // 사용자의 진짜 현재 위치
    var currentCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    // user의 lat, long으로 region 계산해서 user.region에 넣어주는 메서드
    func updateRegion(lat: Double, long:Double) {
        let lat = lat + 90
        let long = long + 180
        
        let stringLat = deleteDecimal(num: lat)
        let stringLong = deleteDecimal(num: long)
        let region = Int(stringLat + stringLong) ?? 0
    
        user.region.accept(region)
    }
    
    // 받은 Double에서 소수점을 제거하고 앞 5개의 숫자를 String으로 리턴해주는 함수
    func deleteDecimal(num: Double) -> String {
        let stringNum = String(format: "%.4f", num).components(separatedBy: ["."]).joined()
        let firstFiveCharacters = String(stringNum.prefix(5))
        
        return firstFiveCharacters
    }
    
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
    
    func filterFriendData(gender: Gender) -> [FromQueueDB] {
        var friendList = friendData.value.fromQueueDB
        
        if gender != .unknown {
            friendList = friendList.filter { $0.gender == gender.rawValue }
        }
        
        return friendList
    }
    
    func hobbyListFromServer() {
        let recommendedHobby = friendData.value.fromRecommend
        let friendList = friendData.value.fromQueueDB
        let requestList = friendData.value.fromQueueDBRequested
        var nearFriendHobby: [String] = []
        
        for friendData in friendList + requestList {
            nearFriendHobby.append(contentsOf: friendData.hf)
        }
        
        // 중복 제거 -> 취미의 순서가 크게 중요하지 않다고 생각해서 Set 사용 -> View 진입할 때 마다 보여주는 취미의 순서가 달라짐
        let removedDuplicate: Set = Set(nearFriendHobby)
        nearFriendHobby = Array(removedDuplicate)
        
        hobbyFromServer.accept((recommendedHobby, nearFriendHobby))
        totalHobby.accept(recommendedHobby + nearFriendHobby)
    }
    
    func checkMyStatus(completion: @escaping (QueueState?, MyQueueStatus) -> Void) {
        QueueAPI.myQueueState { queueState, status in
            switch status {
            case .success:
                completion(queueState, .success)
            case .firebaseTokenError:
                TokenAPI.updateIDToken{
                    QueueAPI.myQueueState { queueState, status in
                        guard let queueState = queueState else {
                            completion(nil, .serverError)
                            return
                        }
                        completion(queueState, .success)
                    }
                }
            default:
                completion(nil, status)
            }
        }
    }
    
    func deleteMyHobby(_ index: Int) {
        var currentMyHobby = user.hobbyList.value
        currentMyHobby.remove(at: index)
        
        user.hobbyList.accept(currentMyHobby)
    }
    
    // collectionView Section1에서 클릭해서 추가하는 경우
    func addMyHobbyFromTotalHobby(_ index: Int, completion: @escaping (String) -> Void) {
        let totalHobby = totalHobby.value
        
        var currentMyHobby = user.hobbyList.value
        let selectedHobby = totalHobby[index]
        // 클릭한 Hobby가 이미 myHobby list에 있는 경우 -> 중복된거 안된다고 toast 띄우기
        if currentMyHobby.contains(selectedHobby) {
            completion("이미 등록된 취미입니다")
        } else if currentMyHobby.count == 8 {
            // 이미 추가된 취미가 8개인 경우
            completion("취미를 더 이상 추가할 수 없습니다")
        } else {
            currentMyHobby.append(selectedHobby)
            user.hobbyList.accept(currentMyHobby)
        }
    }
    
    func addMyHobbyFromInputText(_ inputText: String, completion: @escaping (String) -> Void) {
        let inputTextArray = inputText.components(separatedBy: " ")
        var isOverlapped = false
        var isOverEight = false
        var isSuitable = true
        
        var currentHobby = user.hobbyList.value
        // 중복, 8개 이상
        
        for input in inputTextArray {
            if input.count < 1 || input.count > 8 {
                isSuitable = false
            } else if currentHobby.contains(input) {
                isOverlapped = true
            } else if currentHobby.count == 8 {
                isOverEight = true
                break
            } else {
                currentHobby.append(input)
            }
        }
        
        user.hobbyList.accept(currentHobby)
        
        // 중복만 된 경우, 8개만 넘은 경우, 중복되고 8개를 넘은 경우
        if !isSuitable {
            completion("최소 한 자 이상, 최대 8글자까지 작성 가능합니다")
        } else if isOverlapped && isOverEight {
            completion("중복되지 않은 취미에 한해 8개까지 추가할 수 있습니다.")
        } else if isOverlapped && !isOverEight {
            completion("이미 등록된 취미입니다")
        } else if isOverEight && !isOverlapped {
             completion("취미를 더 이상 추가할 수 없습니다")
        }
    }
    
    func sendQueue(completion: @escaping (String?, QueueStatus?) -> Void) {
        QueueAPI.queue { status in
            switch status {
            case .success:
                completion(nil, .success)
            case .reportMoreThenThreeTimes:
                completion("신고가 누적되어 이용하실 수 없습니다.", nil)
            case .penaltyLevel1:
                completion("약속 취소 패널티로, 1분동안 이용하실 수 없습니다", nil)
            case .penaltyLevel2:
                completion("약속 취소 패널티로, 2분동안 이용하실 수 없습니다", nil)
            case .penaltyLevel3:
                completion("연속으로 약속을 취소하셔서 3분동안 이용하실 수 없습니다", nil)
            case .genderNotSelected:
                completion("새싹 찾기 기능을 이용하기 위해서는 성별이 필요해요!", .genderNotSelected)
            case .notMember:
                completion("회원이 아닙니다", nil)
            case .serverError:
                completion("오류가 발생했습니다. 잠시 후에 다시 시도해주세요", nil)
            default:
                break
            }
        }
    }
}
