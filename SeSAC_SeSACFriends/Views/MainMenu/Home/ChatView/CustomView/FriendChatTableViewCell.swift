//
//  FriendChatTableViewCell.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/22.
//

import UIKit

final class FriendChatTableViewCell: UITableViewCell, BaseCell {
    
    let bubbleView: SpeechBubbleView = {
        let view = SpeechBubbleView()
        view.bubbleType = .friendBubble
        return view
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .Title6_R12
        label.textColor = .gray6
        return label
    }()
    
    static var identifier = "FriendChatTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
        setupCellConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        [bubbleView, timeLabel].forEach { subView in
            self.addSubview(subView)
        }
    }
    
    func setupCellConstraint() {
        bubbleView.snp.makeConstraints {
            $0.leading.top.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
            $0.width.lessThanOrEqualTo(UIScreen.main.bounds.width * 0.7)
        }
        
        timeLabel.snp.makeConstraints {
            $0.bottom.equalTo(bubbleView.snp.bottom)
            $0.leading.equalTo(bubbleView.snp.trailing).inset(-10)
        }
    }
}
