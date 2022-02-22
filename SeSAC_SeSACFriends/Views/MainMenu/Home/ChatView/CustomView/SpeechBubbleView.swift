//
//  SpeechBubbleView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/22.
//

import UIKit

enum BubbleType {
    case myBubble
    case friendBubble
}

class SpeechBubbleView: UIView, BaseView {
    
    var bubbleType: BubbleType = .myBubble {
        didSet {
            switch bubbleType {
            case .myBubble:
                containerView.layer.borderWidth = 0
                containerView.backgroundColor = .brandWhitegreen
                
            case .friendBubble:
                containerView.layer.borderWidth = 1
                containerView.layer.borderColor = UIColor.gray4?.cgColor
                containerView.backgroundColor = .customWhite
            }
        }
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    let chatTextLabel: UILabel = {
        let label = UILabel()
        label.font = .Title3_M14
        label.textColor = .customBlack
        label.numberOfLines = 0
        return label
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
        [containerView, chatTextLabel].forEach { subView in
            self.addSubview(subView)
        }
    }
    
    func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        chatTextLabel.snp.makeConstraints {
            $0.edges.equalTo(containerView).inset(16)
        }
    }
}
