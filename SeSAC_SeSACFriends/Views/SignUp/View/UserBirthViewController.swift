//
//  UserBirthViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/22.
//

import UIKit

import RxCocoa
import RxSwift

class UserBirthViewController: BaseViewController {
    
    let mainView = UserBirthView()
    
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
        let birth = viewModel.user.birth.value
        mainView.datePicker.date = birth
        let dateList = birth.returnDateComponent()
        mainView.yearView.textField.text = dateList[0]
        mainView.monthView.textField.text = dateList[1]
        mainView.dateView.textField.text = dateList[2]
    }
    
    func bind() {
        mainView.datePicker
            .rx.date
            .bind(to: viewModel.user.birth)
            .disposed(by: disposeBag)
        
        viewModel.user.birth
            .bind { [self] birthDay in
                let dateList = birthDay.returnDateComponent()
                self.mainView.yearView.textField.text = dateList[0]
                self.mainView.monthView.textField.text = dateList[1]
                self.mainView.dateView.textField.text = dateList[2]
            }
            .disposed(by: disposeBag)
        
        viewModel.isBirthValid
            .subscribe { isValid in
                isValid.element! ? self.mainView.nextButton.fill() : self.mainView.nextButton.disable()
                self.isValid = isValid.element!
            }
            .disposed(by: disposeBag)
        
        mainView.nextButton
            .rx.tap
            .subscribe { _ in
                if self.isValid {
                    let vc = UserEmailViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    self.view.makeToast("새싹친구는 만 17세 이상만 사용할 수 있습니다.", duration: 1.0, position: .top)
                }
            }
            .disposed(by: disposeBag)
    }
}
