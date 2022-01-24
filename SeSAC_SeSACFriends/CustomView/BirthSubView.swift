//
//  BirthSubView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/24.
//

import UIKit
import SnapKit
import RxSwift

class BirthSubView: UIView {
    
    let textField: UITextField = {
        let field = UITextField()
//        field.setDatePicker()
        return field
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "년"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        [textField, textLabel].forEach { subView in
            self.addSubview(subView)
        }
    }
    
    func setUpConstraints() {
        textField.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.height.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        textLabel.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.2)
            $0.height.equalToSuperview()
            $0.leading.equalTo(textField.snp.trailing)
        }
    }
}
