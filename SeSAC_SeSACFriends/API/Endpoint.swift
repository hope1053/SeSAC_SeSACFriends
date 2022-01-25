//
//  Endpoint.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/21.
//

import Foundation
import Alamofire

enum Endpoint {
    case signIn
}

extension Endpoint {
    var url: URL {
        switch self {
        case .signIn:
            return .makeEndpoint("user")
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com:35484/"
    
    static func makeEndpoint(_ endPoint: String) -> URL {
        URL(string: baseURL + endPoint)!
    }
}
