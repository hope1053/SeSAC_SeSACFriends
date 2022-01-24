//
//  UserBirthViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/22.
//

import UIKit

import RxCocoa
import RxSwift

class UserBirthViewController: BaseViewController {
    
    let viewModel = SignUpViewModel()
    let disposeBag = DisposeBag()
    
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(BGTapped))
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        nextButton
            .rx.tap
            .subscribe { _ in
                let vc = UserEmailViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureView() {
        super.configureView()
        
        [guideLabel, stackView, nextButton].forEach { subView in
            view.addSubview(subView)
        }
        
        yearView.textField.becomeFirstResponder()
        
        [yearView, monthView, dateView].forEach { subView in
            stackView.addArrangedSubview(subView)
            subView.textField.inputView = setDatePicker()
        }
        view.addGestureRecognizer(tapGesture)
    }
    
    override func setupConstraints() {
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
    
    func setDatePicker() -> UIDatePicker {
        let bound = UIScreen.main.bounds
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: bound.width, height: bound.height / 3))
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko_KR")
        datePicker.maximumDate = Date()
//        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        datePicker
            .rx.date
            .bind(to: viewModel.userBirthObserver)
            .disposed(by: disposeBag)
        
        viewModel.isBirthValid
            .subscribe { valid in
                print(valid.element)
                valid.element! ? self.nextButton.fill() : self.nextButton.disable()
            }
            .disposed(by: disposeBag)
        return datePicker
    }
    
//    @objc func dateChanged(_ sender: UIDatePicker) {
//        viewModel.userBirth = sender.date
//        let dateComponent = returnDateComponent(sender.date)
//
//        yearView.textField.text = dateComponent[0]
//        monthView.textField.text = dateComponent[1]
//        dateView.textField.text = dateComponent[2]
//    }
    
    @objc func BGTapped() {
        print("tapped")
        view.endEditing(true)
    }
    
    func returnDateComponent(_ selectedDate: Date) -> [String] {
        var dates: [String] = []
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY"
        dates.append(dateFormatter.string(from: selectedDate))
        dateFormatter.dateFormat = "M"
        dates.append(dateFormatter.string(from: selectedDate))
        dateFormatter.dateFormat = "d"
        dates.append(dateFormatter.string(from: selectedDate))
        return dates
    }
}
