//
//  MyChatTableViewCell.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/22.
//

import UIKit

class MyChatTableViewCell: UITableViewCell, BaseView {
    
    let bubbleView: SpeechBubbleView = {
        let view = SpeechBubbleView()
        view.bubbleType = .myBubble
        return view
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        
        label.font = .Title6_R12
        label.textColor = .gray6
        
        return label
    }()
    
    static let identifier = "MyChatTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        [bubbleView, timeLabel].forEach { subView in
            self.addSubview(subView)
        }
    }
    
    func setupConstraints() {
        bubbleView.snp.makeConstraints {
            $0.trailing.top.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
            $0.width.lessThanOrEqualTo(UIScreen.main.bounds.width * 0.7)
        }
        
        timeLabel.snp.makeConstraints {
            $0.bottom.equalTo(bubbleView.snp.bottom)
            $0.trailing.equalTo(bubbleView.snp.leading).inset(-10)
        }
    }
}
