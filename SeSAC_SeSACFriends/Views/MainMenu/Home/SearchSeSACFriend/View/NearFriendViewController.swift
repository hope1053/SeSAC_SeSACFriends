//
//  NearFriendViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/16.
//

import RxSwift
import UIKit

class NearFriendViewController: BaseViewController {
    
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
        mainView.noSeSACLabel.text = "아쉽게도 주변에 새싹이 없어요ㅠ"
        mainView.noSeSACSubLabel.text = "취미를 변경하거나 조금만 더 기다려 주세요"
        
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
                print("FriendData!!!!!!!", data)
                let nearDataArray = data.fromQueueDB
                
                self.viewModel.updateArray("near")
                self.mainView.updateUI(!nearDataArray.isEmpty)
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

extension NearFriendViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.nearFriendCount)
        return viewModel.nearFriendCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SeSACFriendRequestCell.identifier, for: indexPath) as? SeSACFriendRequestCell else {
            return UITableViewCell()
        }
        
        let data = viewModel.nearFriendData[indexPath.row]
        
        cell.cardView.nameView.userNickNameLabel.text = data.nick
        cell.arrowButtonTapHandler = {
            print("arrowButtonTapHandler")
            self.mainView.tableView.reloadRows(at: [IndexPath(item: indexPath.item, section: indexPath.section)], with: .fade)
        }
        
        return cell
    }
}


