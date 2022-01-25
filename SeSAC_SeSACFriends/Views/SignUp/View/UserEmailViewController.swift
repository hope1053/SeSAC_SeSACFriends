//
//  UserEmailViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/22.
//

import UIKit

import RxCocoa
import RxSwift

class UserEmailViewController: BaseViewController {
    
    let mainView = UserEmailView()
    
    let viewModel = SignUpViewModel()
    let disposeBag = DisposeBag()
    var isValid = false
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
//        userEmailTextField
//            .rx.text
//            .orEmpty
//            .bind(to: viewModel.userNameObserver)
//            .disposed(by: disposeBag)
//
//        viewModel.isUserNameValid
//            .subscribe { isValid in
//                isValid.element! ? self.nextButton.fill() : self.nextButton.disable()
//                self.isValid = isValid.element!
//            }
//            .disposed(by: disposeBag)

        mainView.nextButton
            .rx.tap
            .subscribe { _ in
                let vc = UserGenderViewController()
                self.navigationController?.pushViewController(vc, animated: true)
//                if self.isValid {
//                    let vc = UserBirthViewController()
//                    self.navigationController?.pushViewController(vc, animated: true)
//                } else {
//                    self.view.makeToast("닉네임은 1자 이상 10자 이내로 부탁드려요.", duration: 1.0, position: .bottom)
//                }
            }
            .disposed(by: disposeBag)
    }
}
