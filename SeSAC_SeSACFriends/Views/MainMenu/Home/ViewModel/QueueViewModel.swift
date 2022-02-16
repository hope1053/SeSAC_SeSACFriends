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
    let myHobby = BehaviorRelay<[String]>(value: [])
    
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
        
        hobbyFromServer.accept((recommendedHobby, nearFriendHobby))
        totalHobby.accept(recommendedHobby + nearFriendHobby)
    }
    
    func checkMyStatus(completion: @escaping (QueueState?, QueueAPIStatus) -> Void) {
        QueueAPI.myQueueState { queueState, status in
            switch status {
            case .success:
                completion(queueState, .success)
            case .firebaseTokenError:
                TokenAPI.updateIDToken()
                QueueAPI.myQueueState { queueState, status in
                    guard let queueState = queueState else {
                        completion(nil, .serverError)
                        return
                    }
                    completion(queueState, .success)
                }
            default:
                completion(nil, status)
            }
        }
    }
    
    func deleteMyHobby(_ index: Int) {
        var currentMyHobby = myHobby.value
        currentMyHobby.remove(at: index)
        
        myHobby.accept(currentMyHobby)
    }
    
    // collectionView Section1에서 클릭해서 추가하는 경우
    func addMyHobbyFromTotalHobby(_ index: Int, completion: @escaping () -> Void) {
        let totalHobby = totalHobby.value
        
        var currentMyHobby = myHobby.value
        let selectedHobby = totalHobby[index]
        // 클릭한 Hobby가 이미 myHobby list에 있는 경우 -> 중복된거 안된다고 toast 띄우기
        if currentMyHobby.contains(selectedHobby) {
            completion()
        } else {
            currentMyHobby.append(selectedHobby)
            myHobby.accept(currentMyHobby)
        }
    }
    
    func addMyHobbyFromInputText(_ inputText: String, completion: @escaping () -> Void) {
        let inputTextArray = inputText.components(separatedBy: " ")
        var isOverlapped = false
        
        var currentHobby = self.myHobby.value
        
        for input in inputTextArray {
            if currentHobby.contains(input) {
                isOverlapped = true
            } else {
                currentHobby.append(input)
            }
        }
        
        self.myHobby.accept(currentHobby)
        
        if isOverlapped {
            completion()
        }
    }
}
