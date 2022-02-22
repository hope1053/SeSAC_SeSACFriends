//
//  ChatViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/15.
//

import UIKit

import RxCocoa
import RxSwift
import RxRealm

class ChatViewController: BaseViewController {
    
    let viewModel = ChatViewModel()
    
    let disposeBag = DisposeBag()
    
    let mainView = ChatView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        
        addKeyboardNotification()
        
        checkStatus()
        
        SocketIOManager.shared.establishConnection()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        removeKeyboardNotification()
        
        SocketIOManager.shared.closeConnection()
    }
    
    override func configureView() {
        super.configureView()
        
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        // 타이틀 설정
        title = "고래밥"
        
        view.addSubview(mainView)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "more"), style: .plain, target: self, action: #selector(moreButtonTapped))
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.chatInputView.chatInputTextView.delegate = self
    }
    
    override func setupConstraints() {
        mainView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func bind() {
        mainView.chatInputView.sendButton
            .rx.tap
            .bind { _ in
                self.mainView.chatInputView.chatInputTextView.resignFirstResponder()
            }
            .disposed(by: disposeBag)
        
        mainView.chatInputView.chatInputTextView
            .rx.text
            .orEmpty
            .bind(to: viewModel.inputChatText)
            .disposed(by: disposeBag)

        viewModel.inputChatText
            .map { $0 == "" }
            .bind { [self] isEmpty in
                mainView.chatInputView.sendButton.isEnabled = !isEmpty && viewModel.currentTextColorIsBlack
            }
            .disposed(by: disposeBag)
        
        viewModel.friendName
            .bind { name in
                self.title = name
            }
            .disposed(by: disposeBag)
        
        mainView.chatInputView.sendButton
            .rx.tap
            .bind { _ in
                self.sendChat()
            }
            .disposed(by: disposeBag)
    }
    
    func addKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustInputView), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func checkStatus() {
        viewModel.checkMyStatus { status in
            switch status {
            case .appointmentCancelled:
                self.view.makeToast("약속이 종료되어 채팅을 보낼 수 없습니다", duration: 1.0, position: .bottom) { _ in
                    self.navigationController?.popViewController(animated: true)
                }
            case .matchingStopped:
                self.view.makeToast("오랜 시간 동안 매칭 되지 않아 새싹 친구 찾기를 그만둡니다", duration: 1.0, position: .bottom) { _ in
                    self.navigationController?.popViewController(animated: true)
                }
            case .serverError:
                self.view.makeToast("에러가 발생했습니다. 잠시 후에 다시 시도해주세요", duration: 1.0, position: .bottom)
            }
        }
    }
    
    func sendChat() {
        viewModel.sendChat { status in
            switch status {
            case .success:
                // tableView reload
                self.resetTextView()
                print(status)
            case .matachingStopped:
                self.view.makeToast("약속이 종료되어 채팅을 보낼 수 없습니다", duration: 1.0, position: .bottom)
            case .serverError:
                self.view.makeToast("에러가 발생했습니다. 잠시 후에 다시 시도해주세요", duration: 1.0, position: .bottom)
            }
        }
    }
    
    @objc func moreButtonTapped() {
        print("tapped")
    }
    
    @objc func adjustInputView(noti: Notification) {
        guard let userInfo = noti.userInfo else { return }
        
        guard let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if noti.name == UIResponder.keyboardWillShowNotification {
            let adjustmentHeight = keyboardFrame.height - view.safeAreaInsets.bottom
            mainView.chatInputView.snp.updateConstraints {
                $0.bottom.equalToSuperview().inset(adjustmentHeight)
            }
        } else {
            mainView.chatInputView.snp.updateConstraints {
                $0.bottom.equalToSuperview()
            }
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

extension ChatViewController: UITextViewDelegate {
    
    // 입력 3줄까지 제한
    func textViewDidChange(_ textView: UITextView) {
        let frame = textView.frame
        let size = CGSize(width: frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
    
        if estimatedSize.height > 61 {
            mainView.chatInputView.chatInputTextView.snp.updateConstraints {
                $0.height.equalTo(61)
            }
        } else {
            mainView.chatInputView.chatInputTextView.snp.updateConstraints {
                $0.height.equalTo(estimatedSize.height)
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .gray7 {
            textView.text = nil
            textView.textColor = .customBlack
            viewModel.currentTextColorIsBlack = true
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            resetTextView()
        }
    }
    
    func resetTextView() {
        mainView.chatInputView.chatInputTextView.text = "메세지를 입력하세요"
        mainView.chatInputView.chatInputTextView.textColor = .gray7
        viewModel.currentTextColorIsBlack = false
    }
}
