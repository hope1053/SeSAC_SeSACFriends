//
//  NearFriendViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/16.
//

import RxSwift
import UIKit

final class NearFriendViewController: BaseViewController {
    
    var delegate: RefreshUI?
    
    var disposeBag = DisposeBag()
    
    let viewModel = SearchingFriendViewModel()
    
    let mainView = SeSACFriendView()
    
    let requestView = CustomAlertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        
        NotificationCenter.default.addObserver(self, selector: #selector(nearFriendNoti), name: NSNotification.Name(rawValue: "nearFriendNoti"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "nearFriendNoti"), object: nil)
    }
    
    @objc func nearFriendNoti() {
        callFriendData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callFriendData()
    }
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(mainView)
        mainView.noSeSACLabel.text = "아쉽게도 주변에 새싹이 없어요ㅠ"
        mainView.noSeSACSubLabel.text = "취미를 변경하거나 조금만 더 기다려 주세요"
        
        mainView.tableView.register(SeSACFriendRequestCell.self, forCellReuseIdentifier: SeSACFriendRequestCell.identifier)
        
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
                let nearDataArray = data.fromQueueDB
                
                self.viewModel.updateArray("near")
                self.delegate?.updateButtonUI(nearDataArray.isEmpty)
                self.mainView.updateUI(!nearDataArray.isEmpty)
                self.mainView.tableView.reloadData()
            }
            .disposed(by: disposeBag)
        
        requestView.okButton
            .rx.tap
            .bind { _ in
                self.sendRequest()
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
    
    func sendRequest() {
        QueueAPI.hobbyRequest { status in
            switch status {
            case .success:
                self.view.makeToast("취미 함께 하기 요청을 보냈습니다", duration: 1.0, position: .top)
            case .alreadyRequested:
                self.view.makeToast("상대방도 요청했음!", duration: 1.0, position: .top)
            case .friendStoppedRequest:
                self.view.makeToast("친구가 요청 취소함~", duration: 1.0, position: .top)
                self.callFriendData()
            default:
                print(status)
            }
        }
    }
}

extension NearFriendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.nearFriendCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SeSACFriendRequestCell.identifier, for: indexPath) as? SeSACFriendRequestCell else {
            return UITableViewCell()
        }
        
        let data = viewModel.nearFriendData[indexPath.row]
        
        cell.cardView.nameView.userNickNameLabel.text = data.nick
        cell.updateUI(viewModel.nearFriendIsSelected[indexPath.row])
        
        cell.cardView.arrowButtonTapHandler = { isSelected in
            self.viewModel.nearFriendIsSelected[indexPath.row] = isSelected
            self.mainView.tableView.reloadData()
        }
        
        cell.cardView.requestAcceptButtonTapHandler = {
            self.viewModel.updateFriendUID("near", indexPath.row) {
                self.requestView.showAlert(title: "취미 같이 하기를 요청할게요!", subTitle: "요청이 수락되면 30분 후에 리뷰를 남길 수 있어요")
            }
        }
        
        return cell
    }
}


