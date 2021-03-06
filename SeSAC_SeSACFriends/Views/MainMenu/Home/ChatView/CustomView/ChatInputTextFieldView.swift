//
//  ChatInputTextFieldView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/22.
//

import UIKit

final class ChatInputTextFieldView: UIView, BaseView {
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .gray1
        return view
    }()
    
    let chatInputTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .gray1
        view.font = .Body3_R14
        view.text = "메세지를 입력하세요"
        view.textColor = .gray7
        view.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return view
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "send_inact"), for: .disabled)
        button.setImage(UIImage(named: "send_act"), for: .normal)
        button.isEnabled = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.addSubview(containerView)
        
        [chatInputTextView, sendButton].forEach { subView in
            containerView.addSubview(subView)
        }
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(8)
        }
        
        chatInputTextView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12)
            $0.top.bottom.equalToSuperview().inset(14)
            $0.trailing.equalTo(sendButton.snp.leading).offset(-5)
            $0.height.equalTo(20.333333333333332)
        }
        
        sendButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(14)
            $0.width.equalTo(sendButton.snp.height)
            $0.trailing.equalToSuperview().inset(12)
        }
    }
}
