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

class HomeViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    let button = MainButton(title: "탈퇴버튼", type: .fill)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        
        button.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalTo(200)
            $0.width.equalTo(48)
        }
        
        bind()
    }
    
    override func configureView() {
        super.configureView()
    }
    
    func bind() {
        button
            .rx.tap
            .bind {
                UserAPI.withdraw { error in
                    switch error {
                    case .success:
                        let onboardingView = OnBoardingViewController()
                        let sd = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                        sd?.window?.rootViewController = onboardingView
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
