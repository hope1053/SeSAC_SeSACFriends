//
//  UserNameViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/21.
//

import UIKit

import RxCocoa
import RxSwift
import Toast

class UserNameViewController: BaseViewController {
    
    let mainView = UserNameView()
    
    let viewModel = SignUpViewModel.shared
    
    let disposeBag = DisposeBag()
    var isValid = false

    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(viewModel.user.userName.value)
        print(viewModel.user.birth.value)
        print(viewModel.user.email.value)
        print(viewModel.user.gender.value)
    }
    
    func bind() {
        mainView.userNameTextField
            .rx.text
            .orEmpty
            .bind(to: viewModel.user.userName)
            .disposed(by: disposeBag)

        viewModel.isUserNameValid
            .subscribe { isValid in
                isValid.element! ? self.mainView.nextButton.fill() : self.mainView.nextButton.disable()
                self.isValid = isValid.element!
            }
            .disposed(by: disposeBag)

        mainView.nextButton
            .rx.tap
            .subscribe { _ in
                if self.isValid {
                    let vc = UserBirthViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.view.makeToast("닉네임은 1자 이상 10자 이내로 부탁드려요.", duration: 1.0, position: .bottom)
                }
            }
            .disposed(by: disposeBag)
    }
}
