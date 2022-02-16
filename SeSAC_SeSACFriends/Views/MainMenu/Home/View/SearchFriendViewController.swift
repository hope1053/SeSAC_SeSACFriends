//
//  SearchFriendViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/15.
//

import UIKit

class SearchFriendViewController: BaseViewController {
    
    let viewModel = QueueViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "새싹 찾기"
        
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func configureView() {
        super.configureView()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "찾기중단", style: .plain, target: self, action: #selector(stopSearchingTapped))
    }
    
    @objc func stopSearchingTapped() {
        viewModel.deque { message, status in
            if status == nil {
                self.view.makeToast(message, duration: 1.0, position: .bottom)
            } else if status == .success {
                if let vc = self.navigationController?.viewControllers.last(where: { $0.isKind(of: HomeViewController.self) }) {
                    vc.view.makeToast(message, duration: 1.0, position: .bottom)
                    self.navigationController?.popToViewController(vc, animated: true)
                }
            } else if status == .alreadyMatched {
                self.view.makeToast(message, duration: 1.0, position: .bottom)
                // 채팅화면으로 이동
            }
        }
    }
}
