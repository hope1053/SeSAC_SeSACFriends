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
            "idtoken": UserInfo.shared.idToken ?? ""
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
    
    static func myQueueState(completion: @escaping(QueueState?, MyQueueStatus) -> Void) {
        let userInfo = UserInfo.shared
        
        AF.request(Endpoint.myQueueState.url, method: .get, headers: header).validate().response { response in
            let statusCode = response.response?.statusCode ?? 500
            let queueAPIStatus = MyQueueStatus(rawValue: statusCode)!
            
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
    
    static func queue(completion: @escaping (QueueStatus) -> Void) {
        let user = User.shared
        
        var hobbyList = user.hobbyList.value
        
        if hobbyList.isEmpty {
            hobbyList.append("Anything")
        }
        
        let parameter: [String: Any] = [
            "type": user.preferGender,
            "region": user.region.value,
            "long": user.long.value,
            "lat": user.lat.value,
            "hf": hobbyList
        ]
        
        AF.request(Endpoint.queue.url, method: .post, parameters: parameter, encoding: URLEncoding(arrayEncoding: .noBrackets), headers: header).validate().response { response in
            let statusCode = response.response?.statusCode ?? 500
            let queueStatus = QueueStatus(rawValue: statusCode)!
            
            switch queueStatus {
            case .firebaseTokenError:
                TokenAPI.updateIDToken {
                    queue { status in
                        completion(queueStatus)
                    }
                }
            default:
                completion(queueStatus)
            }
        }
    }
    
    static func dequeue(completion: @escaping (DequeueStatus) -> Void) {
        AF.request(Endpoint.queue.url, method: .delete, headers: header).validate().response { response in
            let statusCode = response.response?.statusCode ?? 500
            let dequeueStatus = DequeueStatus(rawValue: statusCode)!
            
            switch dequeueStatus {
            case .firebaseTokenError:
                TokenAPI.updateIDToken {
                    dequeue { status in
                        completion(dequeueStatus)
                    }
                }
            default:
                completion(dequeueStatus)
            }
        }
    }
    
    static func hobbyRequest(completion: @escaping (HobbyRequestStatus) -> Void) {
        
        let user = User.shared
        
        let parameter: [String: Any] = [
            "otheruid": user.friendUID.value
        ]
        
        print(user.friendUID)
        
        AF.request(Endpoint.hobbyRequest.url, method: .post, parameters: parameter, headers: header).validate().response { response in
            let statusCode = response.response?.statusCode ?? 500
            let hobbyRequestStatus = HobbyRequestStatus(rawValue: statusCode)!
            print(statusCode)
            
            switch hobbyRequestStatus {
            case .firebaseTokenError:
                TokenAPI.updateIDToken{
                    hobbyRequest { status in
                        completion(status)
                    }
                }
            default:
                completion(hobbyRequestStatus)
            }
        }
    }
    
    static func hobbyAccept(completion: @escaping (HobbyAcceptStatus) -> Void) {
        
        let user = User.shared
        
        let parameter: [String: Any] = [
            "otheruid": user.friendUID.value
        ]
        
        AF.request(Endpoint.hobbyAccept.url, method: .post, parameters: parameter, headers: header).validate().response { response in
            let statusCode = response.response?.statusCode ?? 500
            let hobbyAcceptStatus = HobbyAcceptStatus(rawValue: statusCode)!
            
            switch hobbyAcceptStatus {
            case .firebaseTokenError:
                TokenAPI.updateIDToken{
                    hobbyAccept { status in
                        completion(status)
                    }
                }
            default:
                completion(hobbyAcceptStatus)
            }
        }
    }
}
