//
//  ChatView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/22.
//

import UIKit

class ChatView: UIView, BaseView {
    
    let tableView = UITableView()
    
    let chatInputView = ChatInputTextFieldView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        [tableView, chatInputView].forEach { subView in
            self.addSubview(subView)
        }
        
        tableView.separatorStyle = .none
        
        tableView.register(FriendChatTableViewCell.self, forCellReuseIdentifier: FriendChatTableViewCell.identifier)
        tableView.register(MyChatTableViewCell.self, forCellReuseIdentifier: MyChatTableViewCell.identifier)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
            $0.bottom.equalTo(chatInputView.snp.top)
        }
        
        chatInputView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
