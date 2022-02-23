//
//  Endpoint.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/21.
//

import Foundation
import Alamofire

enum Endpoint {
    case user
    case withdraw
    case update
    case onQueue
    case queue
    case myQueueState
    case hobbyRequest
    case hobbyAccept
    case chat(uid: String)
    case updateFCMToken
//    case lastChat(uid: String, lastDate: Date)
}

extension Endpoint {
    var url: URL {
        switch self {
        case .user:
            return .makeEndpoint("user")
        case .withdraw:
            return .makeEndpoint("user/withdraw")
        case .update:
            return .makeEndpoint("user/update/mypage")
        case .onQueue:
            return .makeEndpoint("queue/onqueue")
        case .myQueueState:
            return .makeEndpoint("queue/myQueueState")
        case .queue:
            return .makeEndpoint("queue")
        case .hobbyRequest:
            return .makeEndpoint("queue/hobbyrequest")
        case .hobbyAccept:
            return .makeEndpoint("queue/hobbyaccept")
        case .chat(uid: let uid):
            return .makeEndpoint("chat/\(uid)")
//        case .lastChat(uid: let uid, lastDate: let lastDate):
//            return .makeEndpoint("chat/\(uid)?lastchatDate=\(lastDate)")
        case .updateFCMToken:
            return .makeEndpoint("user/update_fcm_token")
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com:35484/"
    
    static func makeEndpoint(_ endPoint: String) -> URL {
        URL(string: baseURL + endPoint)!
    }
}
