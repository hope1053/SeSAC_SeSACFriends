//
//  ChatViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/15.
//

import UIKit

class ChatViewController: BaseViewController {
    
    let mainView = ChatView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        // 타이틀 설정
        title = "고래밥"
        
        view.addSubview(mainView)
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    override func setupConstraints() {
        mainView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0 {
            guard let friendCell = tableView.dequeueReusableCell(withIdentifier: FriendChatTableViewCell.identifier, for: indexPath) as? FriendChatTableViewCell else {
                return UITableViewCell()
            }
            
            friendCell.bubbleView.chatTextLabel.text = "안녕하세요 자전거 언제 타실 생각이세요????"
            friendCell.selectionStyle = .none
            friendCell.timeLabel.text = "10:50"
            
            return friendCell
        } else {
            guard let myCell = tableView.dequeueReusableCell(withIdentifier: MyChatTableViewCell.identifier, for: indexPath) as? MyChatTableViewCell else {
                return UITableViewCell()
            }
            
            myCell.bubbleView.chatTextLabel.text = "아아ㅏ아ㅏ아ㅏㅏ아ㅏ아아아아ㅏ아아ㅏ아아ㅏ아ㅏ아아ㅏ아ㅏ아아ㅏ아아아ㅏ아아ㅏ아아아아아아아ㅏ아ㅏ아ㅏㅏ아ㅏ아아아아ㅏ아아ㅏ아아ㅏ아ㅏ아아ㅏ아ㅏ아아ㅏ아아아ㅏ아아ㅏ아아아아아"
            myCell.selectionStyle = .none
            myCell.timeLabel.text = "02:19"
            
            return myCell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
}
