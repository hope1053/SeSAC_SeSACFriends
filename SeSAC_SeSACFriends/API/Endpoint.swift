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

//extension URLSession {
//
////    static func request
//
//    typealias Handler = (Data?, URLResponse?, Error?) -> Void
//
////    static func request<T: Decodable>(_ session: URLSession = .shared, endpoint: URLRequest, completion: @escaping (T?, APIError?) -> Void) {
////        session.dataTask(endpoint) { data, response, error in
////            DispatchQueue.main.async {
////                guard error == nil else {
////                    completion(nil, .failed)
////                    return
////                }
////
////                guard let data = data else {
////                    completion(nil, .noData)
////                    return
////                }
////
////                guard let response = response as? HTTPURLResponse else {
////                    completion(nil, .invalidResponse)
////                    return
////                }
////
////                guard response.statusCode == 200 else {
////                    if response.statusCode == 401 {
////                        completion(nil, .invalidToken)
////                        return
////                    } else {
////                        completion(nil, .failed)
////                        return
////                    }
////                }
////
////                do {
////                    let decoder = JSONDecoder()
////                    let decodedData = try decoder.decode(T.self, from: data)
////
////                    completion(decodedData, nil)
////                } catch {
////                    completion(nil, .invalidData)
////                }
////            }
////        }
////    }
//}
