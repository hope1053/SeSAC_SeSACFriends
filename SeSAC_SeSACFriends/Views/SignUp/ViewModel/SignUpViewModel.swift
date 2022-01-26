//
//  SignUpViewModel.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/22.
//

import Foundation

import RxSwift
import RxRelay

class SignUpViewModel {
    
    static let shared = SignUpViewModel()
    
    let user = User.shared
    
    var isUserNameValid: Observable<Bool> {
        return user.userName.map {
            $0.count >= 1 && $0.count <= 10
        }
    }
    
    var isBirthValid: Observable<Bool> {
        return user.birth.map {
            self.validateBirth($0)
        }
    }
    
    var isEmailValid: Observable<Bool> {
        return user.email.map {
            self.validateEmail($0)
        }
    }
    
    func validateBirth(_ birth: Date) -> Bool {
        let currentYear = Date().getYearInt()
        let bornYear = birth.getYearInt()
        var yearSub = currentYear - bornYear
        
        if birth.compareDate(yearSub) {
            yearSub -= 1
        }
        
        if yearSub >= 17 {
            return true
        }
        
        return false
    }
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
