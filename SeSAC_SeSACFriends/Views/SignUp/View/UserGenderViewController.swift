//
//  UserGenderViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/22.
//

import UIKit

import RxCocoa
import RxSwift
import Toast


class UserGenderViewController: BaseViewController {
    
    let mainView = UserGenderView()
    
    let viewModel = SignUpViewModel.shared
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        bind()
    }
    
    func loadData() {
        let gender = viewModel.user.gender.value
        
        if gender == .woman {
            mainView.womanButton.fill()
        } else if gender == .man {
            mainView.manButton.fill()
        }
    }
    
    func bind() {
        mainView.manButton
            .rx.tap
            .map { Gender.man }
            .bind(to: viewModel.user.gender)
            .disposed(by: disposeBag)
        
        mainView.womanButton
            .rx.tap
            .map { Gender.woman }
            .bind(to: viewModel.user.gender)
            .disposed(by: disposeBag)
        
        viewModel.user.gender
            .observe(on: MainScheduler.asyncInstance)
            .bind { [self] gender in
                let isManSelected = mainView.manButton.isSelected
                let isWomanSelected = mainView.womanButton.isSelected
                
                if !isManSelected && !isWomanSelected {
                    if gender == .woman {
                        mainView.womanButton.isSelected = true
                        mainView.womanButton.fill()
                    } else if gender == .man{
                        mainView.manButton.isSelected = true
                        mainView.manButton.fill()
                    }
                } else if gender == .woman && isWomanSelected {
                    mainView.womanButton.isSelected = false
                    mainView.womanButton.inactive()
                    viewModel.user.gender.accept(.unknown)
                } else if gender == .man && isManSelected {
                    mainView.manButton.isSelected = false
                    mainView.manButton.inactive()
                    viewModel.user.gender.accept(.unknown)
                } else if gender == .woman && isManSelected {
                    mainView.manButton.isSelected = false
                    mainView.womanButton.isSelected = true
                    mainView.manButton.inactive()
                    mainView.womanButton.fill()
                } else if gender == .man && isWomanSelected {
                    mainView.womanButton.isSelected = false
                    mainView.manButton.isSelected = true
                    mainView.womanButton.inactive()
                    mainView.manButton.fill()
                }
            }
            .disposed(by: disposeBag)
        
        mainView.nextButton
            .rx.tap
            .bind {
                APIService.signUp { error in
                    switch error {
                    case .success:
                        APIService.signIn { error in
                            switch error {
                            case .success:
                                let tabBarController = MainTabBarController()
                                let sd = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                                sd?.window?.rootViewController? = tabBarController
                            default:
                                self.view.makeToast("서버 에러입니다")
                            }
                        }
                    case .alreadyMember:
                        self.view.makeToast("이미 회원입니다")
                    case .forbiddenName:
                        // 닉네임 뷰컨트롤러로 돌아가는 코드
                        if let vc = self.navigationController?.viewControllers.last(where: { $0.isKind(of: UserNameViewController.self) }) {
                            vc.view.makeToast("금지된 닉네임입니다.")
                            self.navigationController?.popToViewController(vc, animated: true)
                        }
                    case .serverError:
                        self.view.makeToast("서버 에러입니다")
                    default:
                        self.view.makeToast("모르는 에러입니다")
                    }
                }
            }
            .disposed(by: disposeBag)
    }

}
