//
//  RequestedFriendViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/16.
//

import UIKit

import RxSwift

class RequestedFriendViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    let viewModel = SearchingFriendViewModel()
    
    let mainView = SeSACFriendView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        callFriendData()
    }
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(mainView)
        mainView.noSeSACLabel.text = "아직 받은 요청이 없어요ㅠ"
        mainView.noSeSACSubLabel.text = "취미를 변경하거나 조금만 더 기다려주세요!"
    }
    
    override func setupConstraints() {
        mainView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bind() {
        viewModel.friendData
            .bind { _ in
                self.viewModel.updateArray("near")
                self.mainView.tableView.reloadData()
            }
            .disposed(by: disposeBag)
    }
    
    func callFriendData() {
        viewModel.callFriendData { status in
            switch status {
            case .notMember:
                self.view.makeToast("회원이 아닙니다", duration: 1.0, position: .bottom)
            case .serverError:
                self.view.makeToast("에러가 발생했습니다. 잠시 후 다시 시도해주세요", duration: 1.0, position: .bottom)
            default:
                break
            }
        }
    }
}
