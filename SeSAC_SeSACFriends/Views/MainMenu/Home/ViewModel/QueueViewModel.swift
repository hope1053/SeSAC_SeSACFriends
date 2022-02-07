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
}
