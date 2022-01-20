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
    
    let phoneNumObserver = BehaviorRelay<String>(value: "")
    let authNumObserver = BehaviorRelay<String>(value: "")
    var verifyID: String = ""
    
    var isPhoneNumValid: Observable<Bool> {
        return phoneNumObserver.map { return self.validatePhoneNum(phoneNum: $0) }
    }
    
    var isAuthNumValid: Observable<Bool> {
        return authNumObserver.map {
            print($0.count)
            return $0.count == 6
        }
    }
    
    func requestMsg(completion: @escaping (PhoneNumAuthStatus) -> Void) {
        var result = PhoneNumAuthStatus.success
        PhoneAuthProvider.provider()
            .verifyPhoneNumber("+82\(phoneNumObserver.value)", uiDelegate: nil) { verificationID, error in
                if error == nil {
                    self.verifyID = verificationID ?? ""
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
    
    func requestAuthorization() -> RequestAuthorizationStatus {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verifyID, verificationCode: authNumObserver.value)
        var result = RequestAuthorizationStatus.success
        
        Auth.auth().signIn(with: credential) { success, error in
            if error != nil {
                result = RequestAuthorizationStatus.error
            }
        }
        
        return result
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
