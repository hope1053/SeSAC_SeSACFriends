//
//  RequestedFriendViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/16.
//

import UIKit

import RxSwift

final class RequestedFriendViewController: BaseViewController {
    
    var delegate: RefreshUI?
    
    var disposeBag = DisposeBag()
    
    let viewModel = SearchingFriendViewModel()
    
    let mainView = SeSACFriendView()
    
    let acceptView = CustomAlertView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        
        NotificationCenter.default.addObserver(self, selector: #selector(requestedFriendNoti), name: NSNotification.Name(rawValue: "requestedFriendNoti"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "requestedFriendNoti"), object: nil)
    }
    
    @objc func requestedFriendNoti() {
        callFriendData()
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
        
        mainView.tableView.register(SeSACFriendAcceptCell.self, forCellReuseIdentifier: SeSACFriendAcceptCell.identifier)
        
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
                
                self.delegate?.updateButtonUI(requestedDataArray.isEmpty)
                self.viewModel.updateArray("requested")
                self.mainView.updateUI(!requestedDataArray.isEmpty)
                self.mainView.tableView.reloadData()
            }
            .disposed(by: disposeBag)
        
        acceptView.okButton
            .rx.tap
            .bind { _ in
                self.acceptRequest()
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
    
    func acceptRequest() {
        QueueAPI.hobbyAccept { status in
            switch status {
            case .success:
                // 채팅방이동
                break
            case .friendAlreadyMatched:
                self.view.makeToast("상대방이 이미 다른 사람과 취미를 함께하는 중입니다", duration: 1.0, position: .top)
            case .friendStoppedRequest:
                self.view.makeToast("상대방이 취미 함께 하기를 그만두었습니다", duration: 1.0, position: .top)
            case .alreadyMatched:
                self.view.makeToast("앗! 누군가가 나의 취미 함께 하기를 수락하였어요!", duration: 1.0, position: .top)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SeSACFriendAcceptCell.identifier, for: indexPath) as? SeSACFriendAcceptCell else {
            return UITableViewCell()
        }
        
        let data = viewModel.requestedFriendData[indexPath.row]
        
        cell.cardView.nameView.userNickNameLabel.text = data.nick
        cell.updateUI(viewModel.requestedFriendIsSelected[indexPath.row])
        
        cell.cardView.arrowButtonTapHandler = { isSelected in
            self.viewModel.requestedFriendIsSelected[indexPath.row] = isSelected
            self.mainView.tableView.reloadData()
        }
        
        cell.cardView.requestAcceptButtonTapHandler = {
            self.viewModel.updateFriendUID("request", indexPath.row) {
                self.acceptView.showAlert(title: "취미 같이 하기를 수락할까요?", subTitle: "요청을 수락하면 채팅창에서 대화를 나눌 수 있어요")
            }
        }
        
        return cell
    }
}

