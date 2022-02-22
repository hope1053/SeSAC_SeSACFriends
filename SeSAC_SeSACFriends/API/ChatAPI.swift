//
//  ChatAPI.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/22.
//

import Foundation

import Alamofire

class ChatAPI {
    
    static var header: HTTPHeaders {
        [
            "Content-Type": "application/x-www-form-urlencoded",
            "idtoken": UserDefaults.standard.string(forKey: "idToken") ?? ""
        ]
    }
    
    static func sendChat(text: String, uid: String, completion: @escaping (MyQueueStatus) -> Void) {
        
        let parameter: [String: Any] = [
            "chat": text
        ]
        
        AF.request(Endpoint.sendChat(uid: uid).url, method: .post, parameters: parameter, headers: header).validate().response { response in
            let statusCode = response.response?.statusCode ?? 500
            let APIStatus = MyQueueStatus(rawValue: statusCode)!
            
            switch APIStatus {
            case .success:
                // 응답값을 DB에 저장하라고...? 네..
                guard let data = response.value else { return }
                do {
                    let result = try JSONDecoder().decode(Chat.self, from: data!)
                    print(result)
                    completion(.success)
                } catch {
                    completion(.serverError)
                }
            case .firebaseTokenError:
                TokenAPI.updateIDToken {
                    sendChat(text: text, uid: uid) { status in
                        switch APIStatus {
                        case .success:
                            // 응답값 DB 저장
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
}
