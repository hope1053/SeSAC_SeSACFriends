//
//  TokenAPI.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/05.
//

import Foundation
import Firebase

class TokenAPI {
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
}
