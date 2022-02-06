//
//  ManageInfoViewModel.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/04.
//

import UIKit
import RxRelay
import RxSwift

class ManageInfoViewModel {
    
    static let shared = ManageInfoViewModel()
    
    let user = User.shared
    
    let minAge: CGFloat = 18
    let maxAge: CGFloat = 65
    
    let userInfo = PublishRelay<SignInUser>()
    
    let disposeBag = DisposeBag()
    
    func getUserInfo() {
        UserAPI.signIn { data, status in
            guard let data = data else {return}
            
            switch status {
            case .success:
                self.bind()
                self.userInfo.accept(data)
            default:
                break
            }
        }
    }
    
    func bind() {
        userInfo
            .bind { userInfo in
                let searchable = userInfo.searchable
                let ageMin = userInfo.ageMin
                let ageMax = userInfo.ageMax
                let gender = userInfo.gender
                let hobby = userInfo.hobby
                
                self.user.searchable.accept(searchable)
                self.user.ageMin.accept(ageMin)
                self.user.ageMax.accept(ageMax)
                self.user.gender.accept(Gender(rawValue: gender)!)
                self.user.hobby.accept(hobby)
            }
            .disposed(by: disposeBag)
    }
}
