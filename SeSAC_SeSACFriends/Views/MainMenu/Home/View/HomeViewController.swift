//
//  HomeViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/22.
//

import Foundation
import UIKit

import SnapKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let button = MainButton(title: "탈퇴버튼", type: .fill)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        view.addSubview(button)
        
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(200)
            $0.width.equalTo(48)
        }
        bind()
    }
    
    func bind() {
        button
            .rx.tap
            .bind {
                APIService.withdraw { error in
                    switch error {
                    case .success:
                        let onboardingView = OnBoardingViewController()
                        let sd = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                        sd?.window?.rootViewController = onboardingView
                        
//                        UserDefaults.standard.set(nil, forKey: "idToken")
//                    case .FirebaseTokenError:
//                        self.view.makeToast("파베에러", duration: 1.0, position: .bottom)
                    case .alreadyWithdraw:
                        self.view.makeToast("이미 탈퇴된 회원", duration: 1.0, position: .bottom)
                    case .serverError:
                        self.view.makeToast("에러가 발생했습니다. 잠시 후 다시 시도해주세요", duration: 1.0, position: .bottom)
                    default:
                        self.view.makeToast("에러가 발생했습니다. 잠시 후 다시 시도해주세요", duration: 1.0, position: .bottom)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}
