//
//  APIService.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/21.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIService {
    
    static let header: HTTPHeaders = [
        "Content-Type": "application/x-www-form-urlencoded",
        "idtoken": UserDefaults.standard.string(forKey: "idToken") ?? ""
    ]
    
    // 로그인
    static func signIn(completion: @escaping (APIError?) -> Void) {
        AF.request(Endpoint.user.url, method: .get, headers: header).validate().response { response in
            switch response.result {
            case .success(let value):
                let statusCode = response.response?.statusCode ?? 500
                switch statusCode {
                case 200:
                    // 성공
                    do {
                        let result = try JSONDecoder().decode(SignInUser.self, from: value!)
                        print(result)
                        let uid = result.uid
                        UserDefaults.standard.set(uid, forKey: "uid")
                    } catch {
                        print("error")
                    }
                    completion(APIError.success)
                case 201:
                    // 미가입 회원 -> 닉네임 입력창으로
                    completion(APIError.notMember)
                case 401:
                    // Firebase Error
                    completion(APIError.FirebaseTokenError)
                case 500:
                    completion(APIError.serverError)
                default:
                    completion(APIError.serverError)
                }
            case .failure(_):
                completion(APIError.serverError)
            }
        }
    }
    
    // 회원가입
    static func signUp(completion: @escaping ( APIError?) -> Void) {
        let user = User.shared
        
        let parameter: [String: Any] = [
            "phoneNumber": "+82\(user.phoneNumber.value)",
            "FCMtoken": UserDefaults.standard.string(forKey: "FCMToken")!,
            "nick": user.userName.value,
            "birth": "\(user.birth.value)",
            "email": user.email.value,
            "gender": user.gender.value.rawValue
        ]

        AF.request(Endpoint.user.url, method: .post, parameters: parameter, headers: header).validate().response { response in
            switch response.result {
            case .success(_):
                let statusCode = response.response?.statusCode ?? 500
                switch statusCode {
                case 200:
                    completion(APIError.success)
                case 201:
                    completion(APIError.alreadyMember)
                case 202:
                    completion(APIError.forbiddenName)
                case 401:
                    completion(APIError.FirebaseTokenError)
                case 500:
                    completion(APIError.serverError)
                default:
                    break
                }
            case .failure(_):
                print("error")
            }
        }
    }
    
    static func withdraw(completion: @escaping (APIError?) -> Void) {
        AF.request(Endpoint.withdraw.url, method: .post, headers: header).validate().response { response in
            let statusCode = response.response?.statusCode ?? 500
            switch statusCode {
            case 200:
                UserDefaults.standard.set(nil, forKey: "uid")
                UserDefaults.standard.set(nil, forKey: "idToken")
                completion(APIError.success)
            case 401:
                completion(APIError.FirebaseTokenError)
            case 406:
                completion(APIError.alreadyWithdraw)
            case 500:
                completion(APIError.serverError)
            default:
                break
            }
        }
    }
}
