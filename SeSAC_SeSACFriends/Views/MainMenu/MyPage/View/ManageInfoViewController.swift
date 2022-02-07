//
//  ManageInfoViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/03.
//

import UIKit

import RxSwift
import RxCocoa
import MultiSlider

class ManageInfoViewController: BaseViewController {
    
    let manageInfoView = ManageInfoView()
    
    let viewModel = ManageInfoViewModel.shared
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        viewModel.getUserInfo()
    }
    
    func bind() {
        manageInfoView.userDetailView.phoneSearch.isAllowedSwitch
            .rx.isOn
            .map { $0 ? 1 : 0 }
            .bind(to: viewModel.user.searchable)
            .disposed(by: disposeBag)
        
        manageInfoView.userDetailView.hobby.hobbyTextField.textField
            .rx.text
            .orEmpty
            .bind(to: viewModel.user.hobby)
            .disposed(by: disposeBag)
        
        manageInfoView.userDetailView.gender.womanButton
            .rx.tap
            .map { Gender.woman }
            .bind(to: viewModel.user.gender)
            .disposed(by: disposeBag)
        
        manageInfoView.userDetailView.gender.manButton
            .rx.tap
            .map { Gender.man }
            .bind(to: viewModel.user.gender)
            .disposed(by: disposeBag)
        
        viewModel.userInfo
            .bind { info in
                self.manageInfoView.cardView.nameView.userNickNameLabel.text = info.nick
                
                let userDetailView = self.manageInfoView.userDetailView
                
                self.viewModel.user.gender.accept(Gender(rawValue: info.gender)!)
                
                if info.gender == 0 {
                    userDetailView.gender.womanButton.isSelected = true
                    userDetailView.gender.womanButton.fill()
                } else if info.gender == 1 {
                    userDetailView.gender.manButton.isSelected = true
                    userDetailView.gender.manButton.fill()
                }
                
                userDetailView.hobby.hobbyTextField.textField.text = info.hobby
                
                if info.searchable == 1 {
                    userDetailView.phoneSearch.isAllowedSwitch.isOn = true
                } else {
                    userDetailView.phoneSearch.isAllowedSwitch.isOn = false
                }
                
                userDetailView.friendAgeView.AgeLabel.text = "\(info.ageMin) - \(info.ageMax)"
                userDetailView.friendAgeView.ageSlider.value = [CGFloat(info.ageMin), CGFloat(info.ageMax)]
            }
            .disposed(by: disposeBag)
        
        manageInfoView.userDetailView.friendAgeView.ageSlider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
    }
    
    override func configureView() {
        super.configureView()
        
        title = "정보 관리"
        
        view.addSubview(manageInfoView)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonTapped))
    }
    
    override func setupConstraints() {
        manageInfoView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc func saveButtonTapped() {
        UserAPI.updateInfo() { status in
            switch status {
            case .success:
                self.view.makeToast("저장이 완료되었습니다.", duration: 1.0, position: .bottom)
            case .firebaseTokenError:
                self.view.makeToast("파베에러가 발생했습니다. 잠시 후 다시 시도해주세요", duration: 1.0, position: .bottom)
                TokenAPI.updateIDToken()
            case .notMember:
                self.view.makeToast("미가입 회원입니다.", duration: 1.0, position: .bottom)
            case .serverError:
                self.view.makeToast("서버에러가 발생했습니다. 잠시 후 다시 시도해주세요", duration: 1.0, position: .bottom)
            }
        }
    }
    
    @objc func sliderChanged(_ slider: MultiSlider) {
        let value = slider.value
        let minAge = Int(value[0])
        let maxAge = Int(value[1])
        
        manageInfoView.userDetailView.friendAgeView.AgeLabel.text = "\(minAge) - \(maxAge)"
        viewModel.user.ageMin.accept(minAge)
        viewModel.user.ageMax.accept(maxAge)
    }
}
