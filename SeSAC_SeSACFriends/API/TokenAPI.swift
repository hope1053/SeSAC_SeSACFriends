//
//  TokenAPI.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/05.
//

import Foundation
import Firebase

class TokenAPI {
    static func updateIDToken() {
        Auth.auth().currentUser?.getIDTokenForcingRefresh(true) { token, error in
            if let error = error {
                print(error)
                return;
            }
            print("ID token: \(token!)")
            UserDefaults.standard.set(token, forKey: "idToken")
//            completion()
        }
    }
}
