//
//  ManageInfoViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/03.
//

import UIKit
import RxSwift

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
        viewModel.userInfo
            .bind { info in
                self.manageInfoView.cardView.nameView.userNickNameLabel.text = info.nick
                
                let userDetailView = self.manageInfoView.userDetailView
                
                if info.gender == 0 {
                    userDetailView.gender.womanButton.fill()
                } else if info.gender == 1 {
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
    }
    
    override func configureView() {
        super.configureView()
        title = "정보 관리"
        view.addSubview(manageInfoView)
    }
    
    override func setupConstraints() {
        manageInfoView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
