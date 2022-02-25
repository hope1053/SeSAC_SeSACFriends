//
//  ChatMenuView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/25.
//

import UIKit

final class ChatMenuView: UIView, BaseView {
    
    let reportButton: UIButton = {
        let button = UIButton()
        button.setTitle("새싹 신고", for: .normal)
        button.titleLabel?.font = .Title3_M14
        button.setTitleColor(.customBlack, for: .normal)
        button.setImage(UIImage(named: "siren"), for: .normal)
        button.alignTextBelow()
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("약속 취소", for: .normal)
        button.titleLabel?.font = .Title3_M14
        button.setTitleColor(.customBlack, for: .normal)
        button.setImage(UIImage(named: "cancel_match"), for: .normal)
        button.alignTextBelow()
        return button
    }()
    
    let reviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("리뷰 등록", for: .normal)
        button.titleLabel?.font = .Title3_M14
        button.setTitleColor(.customBlack, for: .normal)
        button.setImage(UIImage(named: "write"), for: .normal)
        button.alignTextBelow()
        return button
    }()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 0
        return view
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
        
        self.backgroundColor = .white
        
        [reportButton, cancelButton, reviewButton].forEach { subView in
            stackView.addArrangedSubview(subView)
        }
        
        self.addSubview(stackView)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
