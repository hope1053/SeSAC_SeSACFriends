//
//  Date+Extension.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/25.
//

import Foundation

extension Date {
    func returnDateComponent() -> [String] {
        var dates: [String] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        dates.append(dateFormatter.string(from: self))
        dateFormatter.dateFormat = "M"
        dates.append(dateFormatter.string(from: self))
        dateFormatter.dateFormat = "d"
        dates.append(dateFormatter.string(from: self))
        return dates
    }
    
    func getYearInt() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        return Int(dateFormatter.string(from: self)) ?? 0
    }
    
    func compareDate(_ sub: Int) -> Bool {
        let currentBirth = Calendar.current.date(byAdding: .year, value: sub, to: self) ?? Date()
        let compareResult = Date().compare(currentBirth)
        
        if compareResult == .orderedAscending {
            return true
        } else {
            return false
        }
    }
}
