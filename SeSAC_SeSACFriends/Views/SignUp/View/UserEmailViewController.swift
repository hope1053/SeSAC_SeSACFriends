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
    
    let viewModel = SignUpViewModel.shared
    let disposeBag = DisposeBag()
    var isValid = false
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        bind()
    }
    
    func loadData() {
        mainView.userEmailTextField.text = viewModel.user.email.value
    }
    
    func bind() {
        mainView.userEmailTextField
            .rx.text
            .orEmpty
            .bind(to: viewModel.user.email)
            .disposed(by: disposeBag)

        viewModel.isEmailValid
            .subscribe { isValid in
                isValid.element! ? self.mainView.nextButton.fill() : self.mainView.nextButton.disable()
                self.isValid = isValid.element!
            }
            .disposed(by: disposeBag)

        mainView.nextButton
            .rx.tap
            .subscribe { _ in
                if self.isValid {
                    let vc = UserGenderViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.view.makeToast("이메일 형식이 올바르지 않습니다.", duration: 1.0, position: .bottom)
                }
            }
            .disposed(by: disposeBag)
    }
}
