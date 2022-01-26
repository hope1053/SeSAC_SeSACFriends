//
//  MainTextFieldView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/25.
//

import UIKit

class MainTextFieldView: UIView {
    
    let textField: MainTextField = {
        let textField = MainTextField()
        textField.textColor = .gray7
        return textField
    }()
    
    let stateLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray3
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        [textField, stateLine].forEach { subView in
            self.addSubview(subView)
        }
    }
    
    func makeConstraints() {
        textField.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(5)
            $0.bottom.equalTo(stateLine.snp.top).offset(-5)
        }
        
        stateLine.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1.3)
            $0.bottom.equalToSuperview()
        }
    }
}

extension MainTextFieldView {
    func inactive() {
        textField.textColor = .gray7
        stateLine.backgroundColor = .gray3
    }
    
    func focus() {
        textField.textColor = .customBlack
        stateLine.backgroundColor = .customBlack
    }
    
    func active() {
        textField.textColor = .customBlack
        stateLine.backgroundColor = .gray3
    }
}
