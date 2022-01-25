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
        
    let userNameObserver = BehaviorRelay<String>(value: "")
    let userBirthObserver = BehaviorRelay<Date>(value: Date())
    
    var isUserNameValid: Observable<Bool> {
        return userNameObserver.map {
            $0.count >= 1 && $0.count <= 10
        }
    }
    
    var isBirthValid: Observable<Bool> {
        return userBirthObserver.map {
            self.validateBirth($0)
        }
    }
    
    func returnDateComponent(_ selectedDate: Date) -> [String] {
        var dates: [String] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        dates.append(dateFormatter.string(from: selectedDate))
        dateFormatter.dateFormat = "M"
        dates.append(dateFormatter.string(from: selectedDate))
        dateFormatter.dateFormat = "d"
        dates.append(dateFormatter.string(from: selectedDate))
        return dates
    }
    
    func validateBirth(_ birth: Date) -> Bool {
        let currentYear = getYearInt(Date())
        let bornYear = getYearInt(birth)
        var yearSub = currentYear - bornYear
        
        // 1. 현재 년도 - 태어난 년도
        // 2. 날짜끼리 비교해서 생일 지났으면 그대로, 안지났으면 -1
        if compareDate(yearSub, birth) {
            yearSub -= 1
        }
        
        print("만 나이는...", yearSub)
        
        if yearSub >= 17 {
            return true
        }
        
        return false
    }
    
    func getYearInt(_ date: Date) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return Int(dateFormatter.string(from: date)) ?? 0
    }
    
    func compareDate(_ sub: Int, _ birth: Date) -> Bool {
        // 올해 생일
        let currentBirth = Calendar.current.date(byAdding: .year, value: sub, to: birth) ?? Date()
        let compareResult = Date().compare(currentBirth)
        
        if compareResult == .orderedAscending {
            return true
        } else {
            return false
        }

    }
}
