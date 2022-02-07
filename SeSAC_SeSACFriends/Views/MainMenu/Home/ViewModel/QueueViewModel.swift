//
//  QueueViewModel.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/07.
//

import Foundation
import CoreLocation

class QueueViewModel {
    
    let user = User.shared
    
    var currentCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    // user의 lat, long으로 region 계산해서 user.region에 넣어주는 메서드
    func getRegion() {
        let lat = user.lat.value + 90
        let long = user.long.value + 180
        
        let stringLat = deleteDecimal(num: lat)
        let stringLong = deleteDecimal(num: long)
        
        let region = Int(stringLat + stringLong) ?? 0
        user.region.accept(region)
    }
    
    // 받은 Double에서 소수점을 제거하고 앞 5개의 숫자를 String으로 리턴해주는 함수
    func deleteDecimal(num: Double) -> String {
        var num = num
        var isDouble = true
        
        repeat {
            num = num * 10
            isDouble = floor(num) != num
        } while isDouble
        
        let stringNum = String(num)
        let firstFiveCharacters = String(stringNum.prefix(5))
        
        return firstFiveCharacters
    }
}
