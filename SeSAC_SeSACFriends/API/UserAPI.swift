//
//  APIService.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/21.
//

import Foundation
import RxSwift
import RxRelay
import Alamofire

class UserAPI {
    
//    let apiState = PublishRelay<APIStatus>()
//    let userResult = PublishRelay<SignInUser>()
    
//    static var header: HTTPHeaders = [
//        "Content-Type": "application/x-www-form-urlencoded",
//        "idtoken": UserDefaults.standard.string(forKey: "idToken") ?? ""
//    ]
    
    static var header: HTTPHeaders {
        [
            "Content-Type": "application/x-www-form-urlencoded",
            "idtoken": UserInfo.shared.idToken ?? ""
        ]
    }
    
//    fileprivate func basicAPIRequest(url: URL, method: HTTPMethod, headers: HTTPHeaders, parameters: Parameters?, completion: @escaping(Data?, APIStatus) -> Void) {
//        if NetworkManager.shared.isReachable {
//            AF.request(url, method: method, parameters: parameters, headers: headers).validate().response { response in
//                guard let value = response.value else { return }
//                let statusCode = APIStatus(rawValue: response.response?.statusCode ?? 500)!
//
//                completion(value, statusCode)
//            }
//        } else {
//            completion(nil, .noConnection)
//        }
//    }
    
    // 로그인
    static func signIn(completion: @escaping (SignInUser?, APIStatus) -> Void) {
        let user = User.shared

        AF.request(Endpoint.user.url, method: .get, headers: header).validate().response { response in
//            let APIStatus = APIstatus(rawValue: response.response?.statusCode ?? 500) ?? APIstatus.serverError
//
//            switch APIStatus {
//            case .success:
//                guard let data = response.value else { return }
//                do {
//                    let result = try JSONDecoder().decode(SignInUser.self, from: data!)
//                    UserDefaults.standard.set(result.uid, forKey: "uid")
//                    user.gender.accept(Gender(rawValue: result.gender)!)
//                    completion(result, APIstatus.success)
//                } catch {
//                    completion(nil, APIstatus.serverError)
//                }
//            default:
//                completion(nil, APIStatus)
//            }
            
            let statusCode = response.response?.statusCode ?? 500
            switch statusCode {
            case 200:
                // 성공
                guard let value = response.value else {return}
                do {
                    let result = try JSONDecoder().decode(SignInUser.self, from: value!)
                    print("uid!!!!!!!!!", result.uid)
                    print("fcm!!!!!!!!!", result.fcMtoken)
                    
                    UserInfo.shared.uid = result.uid
                    user.gender.accept(Gender(rawValue: result.gender)!)
                    
                    if result.fcMtoken != UserInfo.shared.fcmToken {
                        TokenAPI.updateFCMToken()
                    }
                    
                    completion(result, APIStatus.success)
                } catch {
                    completion(nil, APIStatus.serverError)
                }
            case 406:
                // 미가입 회원 -> 닉네임 입력창으로
                completion(nil, APIStatus.notMember)
            case 401:
                // firebase token error
                TokenAPI.updateIDToken {
                    print("updated")
                }
            case 500:
                completion(nil, APIStatus.serverError)
            default:
                completion(nil, APIStatus.serverError)
            }
        }
    }
//    func signIn() {
//        basicAPIRequest(url: .get, method: Endpoint.user.url, headers: header, parameters: nil) { data, status in
//            <#code#>
//        }
//    }
    
    // 회원가입
    static func signUp(completion: @escaping (APIStatus?) -> Void) {
        let user = User.shared
        
        let parameter: [String: Any] = [
            "phoneNumber": "+82\(user.phoneNumber.value)",
            "FCMtoken": UserInfo.shared.fcmToken,
            "nick": user.userName.value,
            "birth": "\(user.birth.value)",
            "email": user.email.value,
            "gender": user.gender.value.rawValue
        ]

        AF.request(Endpoint.user.url, method: .post, parameters: parameter, headers: header).validate().response { response in
            let statusCode = response.response?.statusCode ?? 500
            switch statusCode {
            case 200:
                UserInfo.shared.userName = user.userName.value
                completion(APIStatus.success)
            case 401:
                // firebase token error
                TokenAPI.updateIDToken {
                    signUp { status in
                        completion(status)
                    }
                }
            case 406:
                completion(APIStatus.alreadyWithdraw)
            case 500:
                completion(APIStatus.serverError)
            default:
                break
            }
        }
    }
    
    static func withdraw(completion: @escaping (APIStatus?) -> Void) {
        AF.request(Endpoint.withdraw.url, method: .post, headers: header).validate().response { response in
            let statusCode = response.response?.statusCode ?? 500
            switch statusCode {
            case 200:
                // 회원 탈퇴 성공 시, 저장된 uid, idToken 모두 삭제
                UserInfo.shared.uid = nil
                UserInfo.shared.idToken = nil
                completion(APIStatus.success)
            case 401:
                // firebase token error
                TokenAPI.updateIDToken{
                    withdraw { status in
                        completion(status)
                    }
                }
                break
            case 406:
                completion(APIStatus.alreadyWithdraw)
            case 500:
                completion(APIStatus.serverError)
            default:
                break
            }
        }
    }
    
    static func updateInfo(completion: @escaping (APIstatus) -> Void) {
        let user = User.shared
        
        let parameter: [String: Any] = [
            "searchable": user.searchable.value,
            "ageMin": user.ageMin.value,
            "ageMax": user.ageMax.value,
            "gender": user.gender.value.rawValue,
            "hobby": user.hobby.value,
        ]
        
        AF.request(Endpoint.update.url, method: .post, parameters: parameter, headers: header).validate().response { response in
            let APIStatus = APIstatus(rawValue: response.response?.statusCode ?? 500) ?? APIstatus.serverError
            
            switch APIStatus {
            case .firebaseTokenError:
                TokenAPI.updateIDToken {
                    updateInfo { status in
                        completion(status)
                    }
                }
            default:
                completion(APIStatus)
            }
        }
    }
}
