//
//  APIService.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/21.
//

import Foundation
import Alamofire

class APIService {
    
//    let idToken = UserDefaults.standard.string(forKey: "idToken") ?? ""
    static let header: HTTPHeaders = [
        "idtoken": UserDefaults.standard.string(forKey: "idToken") ?? ""
    ]
    
    static func signIn(completion: @escaping (APIError?) -> Void) {
        AF.request(Endpoint.signIn.url, method: .get, headers: header).validate().response { response in
            switch response.result {
            case .success(_):
                let statusCode = response.response?.statusCode ?? 500
                switch statusCode {
                case 200:
                    completion(nil)
                case 201:
                    completion(APIError.notMember)
                case 401:
                    completion(APIError.FirebaseTokenError)
                case 500:
                    completion(APIError.serverError)
                default:
                    completion(APIError.serverError)
                }
            case .failure(_):
                completion(APIError.serverError)
            }
        }
    }
}
