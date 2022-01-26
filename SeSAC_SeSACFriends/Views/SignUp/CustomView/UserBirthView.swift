//
//  UserBirthView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/25.
//

import UIKit

class UserBirthView: UIView {
    
    let guideLabel: UILabel = {
        let label = UILabel()
        label.text = "생년월일을 알려주세요"
        label.font = .Display1_R20
        label.textColor = UIColor.customBlack
        label.textAlignment = .center
        return label
    }()
    
    let yearView: BirthSubView = {
        let view = BirthSubView()
        return view
    }()
    
    let monthView: BirthSubView = {
        let view = BirthSubView()
        view.textLabel.text = "월"
        return view
    }()
    let dateView: BirthSubView = {
        let view = BirthSubView()
        view.textLabel.text = "일"
        return view
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        return stack
    }()
    
    let nextButton: MainButton = {
        let button = MainButton(title: "다음", type: .disable)
        return button
    }()
    
    let datePicker: UIDatePicker = {
        let bound = UIScreen.main.bounds
        let picker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: bound.width, height: bound.height / 3))
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "ko_KR")
        picker.maximumDate = Date()
        return picker
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
        [guideLabel, stackView, nextButton, datePicker].forEach { subView in
            self.addSubview(subView)
        }
        
        yearView.textField.becomeFirstResponder()
        
        [yearView, monthView, dateView].forEach { subView in
            stackView.addArrangedSubview(subView)
            subView.textField.inputView = datePicker
        }
    }
    
    func setupConstraints() {
        guideLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.52)
        }
        
        stackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview().multipliedBy(0.85)
            $0.height.equalTo(48)
        }

        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
            $0.centerY.equalToSuperview().multipliedBy(1.1)
        }
    }
}
