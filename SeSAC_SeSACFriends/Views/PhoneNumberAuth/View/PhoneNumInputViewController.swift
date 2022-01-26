//
//  PhoneNumberInputViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/19.
//

import UIKit

//import AnyFormatKit
import FirebaseAuth
import RxCocoa
import RxSwift
import SnapKit
import Toast

class PhoneNumInputViewController: BaseViewController {
    
    let mainView = PhoneNumInputView()
    
    let viewModel = PhoneNumAuthViewModel()
    let disposeBag = DisposeBag()
    var isValid: Bool = false
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.phoneNumInputView.textField.delegate = self
        bind()
    }
    
    func bind() {

        viewModel.isPhoneNumValid
            .subscribe { valid in
                valid.element! ? self.mainView.getAuthNumButton.fill() : self.mainView.getAuthNumButton.disable()
                self.isValid = valid.element!
            }
            .disposed(by: disposeBag)
        
        mainView.getAuthNumButton
            .rx.tap
            .subscribe { _ in
                self.view.endEditing(true)
                if self.isValid {
                    self.viewModel.requestMsg { status in
                        switch status {
                        case .success:
                            self.view.makeToast("전화 번호 인증 시작", duration: 1.0, position: .bottom) { _ in
                                let vc = PhoneNumAuthViewController()
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        case .overRequest:
                            self.view.makeToast("과도한 인증 시도가 있었습니다. 나중에 다시 시도해주세요", duration: 1.0, position: .bottom)
                        case .error:
                            self.view.makeToast("에러가 발생했습니다. 다시 시도해주세요", duration: 1.0, position: .bottom)
                        }
                    }
                } else {
                    self.view.makeToast("잘못된 전화번호 형식입니다", duration: 1.0, position: .bottom)
                }
            }
            .disposed(by: disposeBag)
    }
}

extension PhoneNumInputViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        mainView.phoneNumInputView.focus()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        mainView.phoneNumInputView.active()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        
        let selectedRange: UITextRange? = textField.selectedTextRange
        let deletePosition = textField.position(from: selectedRange!.start, offset: -1)
        
        let newString = (text as NSString).replacingCharacters(in: range, with: string)
        textField.text = newString.format(with: "XXX-XXXX-XXXX")
        
        if range.length == 1 {
            textField.selectedTextRange = textField.textRange(from: deletePosition!, to: deletePosition!)
        }
        
        viewModel.user.phoneNumber.accept(textField.text!.replacingOccurrences(of: "-", with: ""))
        
        return false
    }
}


