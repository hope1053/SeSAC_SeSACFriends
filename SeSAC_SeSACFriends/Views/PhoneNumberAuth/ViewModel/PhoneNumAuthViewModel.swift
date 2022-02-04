//
//  PhoneNumAuthViewModel.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/20.
//

import Foundation

import FirebaseAuth
import RxSwift
import RxRelay
import RxCocoa

class PhoneNumAuthViewModel {
    
    let user = User.shared
    
    let authNumObserver = BehaviorRelay<String>(value: "")
    
    var phoneNumber: String = ""
    
    var isPhoneNumValid: Observable<Bool> {
        return user.phoneNumber.map { return self.validatePhoneNum(phoneNum: $0) }
    }
    
    var isAuthNumValid: Observable<Bool> {
        return authNumObserver.map { input in
            return input.allSatisfy { $0.isNumber } && input.count == 6
        }
    }
    
    func requestMsg(completion: @escaping (PhoneNumAuthStatus) -> Void) {
        var result = PhoneNumAuthStatus.success
        PhoneAuthProvider.provider()
            .verifyPhoneNumber("+82\(user.phoneNumber.value)", uiDelegate: nil) { verificationID, error in
                if error == nil {
                    UserDefaults.standard.setValue(verificationID ?? "", forKey: "verifyID")
                } else {
                    if let errorNameKey = (error as NSError?)?.userInfo["FIRAuthErrorUserInfoNameKey"] as? String, errorNameKey == "ERROR_TOO_MANY_REQUESTS" {
                        result = .overRequest
                    } else {
                        result = .error
                    }
                }
                completion(result)
          }
    }
    
    func requestAuthorization(completion: @escaping (RequestStatus, APIStatus?) -> Void) {
        let verifyID = UserDefaults.standard.string(forKey: "verifyID") ?? ""
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verifyID, verificationCode: authNumObserver.value)
        
        Auth.auth().signIn(with: credential) { success, error in
            // 핸드폰 인증번호 + verifyID로 인증요청했는데 error가 생긴 경우
            if error != nil {
                completion(RequestStatus.error, nil)
            } else {
                // 성공한 경우 -> firebaes IDToken 요청
                self.requestIDToken { idTokenRequest, apiError in
                    completion(idTokenRequest, apiError)
                }
            }
        }
    }
    
    // firebase에 IDToken 요청
    func requestIDToken(completion: @escaping (RequestStatus, APIStatus?) -> Void) {
        let currentUser = Auth.auth().currentUser
        currentUser?.getIDTokenForcingRefresh(true) { idToken, error in
            // 에러가 생기는 경우
            if error != nil {
                completion(RequestStatus.error, nil)
            } else {
                // IDToken 잘 받아온 경우 -> APIService signin으로 사용자 정보 확인 요청
                print(idToken)
                UserDefaults.standard.setValue(idToken ?? "", forKey: "idToken")
                UserAPI.signIn { data, status in
                    completion(RequestStatus.success, status)
                }
            }
        }
    }
    
    // 유효성검사 메서드
    func validatePhoneNum(phoneNum: String) -> Bool {
        let checkPattern = "^01([0-9])([0-9]{4})([0-9]{4})$"
        let regex = try? NSRegularExpression(pattern: checkPattern)

        if let _ = regex?.firstMatch(in: phoneNum, options: [], range: NSRange(location: 0, length: phoneNum.count)) {
            return true
        }
        return false
    }
}
