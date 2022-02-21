//
//  RequestedFriendViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/16.
//

import UIKit

import RxSwift

class RequestedFriendViewController: BaseViewController {
    
    var delegate: RefreshUI?
    
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
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    override func setupConstraints() {
        mainView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bind() {
        viewModel.friendData
            .bind { data in
                let requestedDataArray = data.fromQueueDBRequested
                
                self.viewModel.updateArray("requested")
                self.mainView.updateUI(!requestedDataArray.isEmpty)
                self.mainView.tableView.reloadData()
            }
            .disposed(by: disposeBag)
    }
    
    func callFriendData() {
        viewModel.callFriendData { status in
            switch status {
            case .success:
                self.delegate?.updateButtonUI(self.viewModel.requestedFriendData.isEmpty)
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

extension RequestedFriendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.requestedFriendCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SeSACFriendRequestCell.identifier, for: indexPath) as? SeSACFriendRequestCell else {
            return UITableViewCell()
        }
        
        let data = viewModel.requestedFriendData[indexPath.row]
        
        cell.cardView.nameView.userNickNameLabel.text = data.nick
        cell.updateUI(viewModel.cellIsSelected[indexPath.row])
        
        cell.cardView.arrowButtonTapHandler = { isSelected in
            self.viewModel.cellIsSelected[indexPath.row] = isSelected
            self.mainView.tableView.reloadData()
        }
        
        return cell
    }
}

