//
//  QueueAPI.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/07.
//

import Foundation

import Alamofire

class QueueAPI {
    
    static var header: HTTPHeaders {
        [
            "Content-Type": "application/x-www-form-urlencoded",
            "idtoken": UserDefaults.standard.string(forKey: "idToken") ?? ""
        ]
    }
    
    static func onQueue(completion: @escaping (FriendSESAC?, APIstatus) -> Void) {
        let user = User.shared
        
        let parameter: [String: Any] = [
            "region": user.region.value,
            "lat": user.lat.value,
            "long": user.long.value
        ]
        
        AF.request(Endpoint.onQueue.url, method: .post, parameters: parameter, headers: header).validate().response { response in
            let statusCode = response.response?.statusCode ?? 500
            let APIStatus = APIstatus(rawValue: statusCode) ?? APIstatus.serverError
            
            switch APIStatus {
            case .success:
                guard let data = response.value else {return}
                do {
                    let result = try JSONDecoder().decode(FriendSESAC.self, from: data!)
                    completion(result, APIstatus.success)
                } catch {
                    completion(nil, APIstatus.serverError)
                }
            default:
                completion(nil, APIStatus)
            }
        }
    }
    
    static func myQueueState(completion: @escaping(QueueState?, QueueAPIStatus) -> Void) {
        let userInfo = UserInfo.shared
        
        AF.request(Endpoint.myQueueState.url, method: .get, headers: header).validate().response { response in
            let statusCode = response.response?.statusCode ?? 500
            let queueAPIStatus = QueueAPIStatus(rawValue: statusCode)!
            
            switch queueAPIStatus {
            case .success:
                guard let data = response.value else { return }
                do {
                    let result = try JSONDecoder().decode(QueueState.self, from: data!)
                    if result.matched == 0 {
                        userInfo.currentQueueState = .status_matching
                    } else {
                        userInfo.currentQueueState = .status_matched
                    }
                    completion(result, .success)
                } catch {
                    completion(nil, .serverError)
                }
            case .matchingStopped:
                userInfo.currentQueueState = .status_default
                completion(nil, .matchingStopped)
            default:
                completion(nil, queueAPIStatus)
            }
        }
    }
}
