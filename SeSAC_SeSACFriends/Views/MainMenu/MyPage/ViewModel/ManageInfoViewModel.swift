//
//  ManageInfoViewModel.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/04.
//

import UIKit
import RxRelay

class ManageInfoViewModel {
    
    static let shared = ManageInfoViewModel()
    
    let minAge: CGFloat = 18
    let maxAge: CGFloat = 65
    
    let userInfo = PublishRelay<SignInUser>()
    
    func getUserInfo() {
        UserAPI.signIn { data, status in
            print("try login...")
            guard let data = data else {return}
            
            switch status {
            case .success:
                print("login....yes")
                self.userInfo.accept(data)
            default:
                break
            }
        }
    }
}
