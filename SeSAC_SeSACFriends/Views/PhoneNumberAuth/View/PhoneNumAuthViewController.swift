//
//  PhoneNumAuthViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/19.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit
import Toast

class PhoneNumAuthViewController: BaseViewController {
    
    let mainView = PhoneNumAuthView()
    
    let viewModel = PhoneNumAuthViewModel()
    
    let disposeBag = DisposeBag()
    
    var isValid: Bool = false
    
    var limitTime: Int = 60
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func configureView() {
        super.configureView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.view.makeToast("인증 번호를 보냈습니다", duration: 1.0, position: .bottom)
        }
        mainView.authNumInputView.textField.delegate = self
        setTime()
    }
    
    func bind() {
        mainView.authNumInputView.textField
            .rx.text
            .orEmpty
            .bind(to: viewModel.authNumObserver)
            .disposed(by: disposeBag)

        viewModel.isAuthNumValid
            .subscribe { valid in
                valid.element! ? self.mainView.authorizeButton.fill() : self.mainView.authorizeButton.disable()
                self.isValid = valid.element!
            }
            .disposed(by: disposeBag)

        mainView.authorizeButton
            .rx.tap
            .subscribe { _ in
                self.view.endEditing(true)
                if self.isValid {
                    self.viewModel.requestAuthorization { requestResult, userInfoRequest in
                        switch requestResult {
                        case .success:
                            switch userInfoRequest {
                            case .success:
                                let vc = HomeViewController()
                                self.navigationController?.pushViewController(vc, animated: true)
                            case .notMember:
                                UserDefaults.standard.set(self.viewModel.user.phoneNumber.value, forKey: "userPhoneNum")
                                let vc = UserNameViewController()
                                self.navigationController?.pushViewController(vc, animated: true)
//                            case .FirebaseTokenError:
//                                self.view.makeToast("에러가 발생했습니다. 잠시 후 다시 시도해주세요", duration: 1.0, position: .bottom)
                            case .serverError:
                                self.view.makeToast("에러가 발생했습니다. 잠시 후 다시 시도해주세요", duration: 1.0, position: .bottom)
                            default:
                                self.view.makeToast("에러가 발생했습니다. 잠시 후 다시 시도해주세요", duration: 1.0, position: .bottom)
                            }
                        case .error:
                            self.view.makeToast("전화번호 인증 실패", duration: 1.0, position: .bottom)
                        }
                    }
                } else {
                    self.view.makeToast("잘못된 인증 번호 형식입니다", duration: 1.0, position: .bottom)
                }
            }
            .disposed(by: disposeBag)
    }
    
    @objc func setTime() {
        secToTime(sec: limitTime)
        limitTime -= 1
    }
    
    func secToTime(sec: Int) {
        let minute = (sec % 3600) / 60
        let second = (sec % 3600) % 60
        
        if second < 10 {
            mainView.timerLabel.text = "0\(minute):0\(second)"
        } else {
            mainView.timerLabel.text = "0\(minute):\(second)"
        }
        
        if limitTime != 0 {
            perform(#selector(setTime), with: nil, afterDelay: 1.0)
        } else {
            self.view.makeToast("전화번호 인증 실패", duration: 1.0, position: .bottom)
            mainView.sendMsgButton.isEnabled = true
            mainView.sendMsgButton.fill()
        }
    }

}

extension PhoneNumAuthViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        mainView.authNumInputView.focus()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        mainView.authNumInputView.active()
    }
}
