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
        
        mainView.datePicker
            .rx.date
            .asDriver(onErrorJustReturn: Date())
            .drive(viewModel.userBirthObserver)
            .disposed(by: disposeBag)
        
        viewModel.userBirthObserver
            .subscribe { date in
                let dateList = self.viewModel.returnDateComponent(date.element ?? Date())
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
