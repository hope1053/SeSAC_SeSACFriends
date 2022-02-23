//
//  TokenAPI.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/05.
//

import Foundation
import Firebase
import Alamofire

class TokenAPI {
    
    static var header: HTTPHeaders {
        [
            "Content-Type": "application/x-www-form-urlencoded",
            "idtoken": UserInfo.shared.idToken ?? ""
        ]
    }
    
    static func updateIDToken(completion: @escaping () -> Void) {
        Auth.auth().currentUser?.getIDTokenForcingRefresh(true) { token, error in
            if let error = error {
                return;
            }
            print("ID token: \(token!)")
            UserInfo.shared.idToken = token
            completion()
        }
    }
    
    static func updateFCMToken() {
        
        let parameter: [String: Any] = [
            "FCMtoken": UserInfo.shared.fcmToken
        ]
        
        AF.request(Endpoint.updateFCMToken.url, method: .put, parameters: parameter, headers: header).validate().response { response in
            let statusCode = response.response?.statusCode ?? 500
            let APIStatus = APIstatus(rawValue: statusCode) ?? APIstatus.serverError
            
            switch APIStatus {
            case .firebaseTokenError:
                TokenAPI.updateIDToken {
                    updateFCMToken()
                }
            default:
                break
            }
        }
    }
}
