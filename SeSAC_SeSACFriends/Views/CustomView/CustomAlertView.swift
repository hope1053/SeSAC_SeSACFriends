//
//  CustomAlertViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/05.
//

import UIKit

class CustomAlertView: UIView, BaseView {
    
    static let shared = CustomAlertView()
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .customBlack
        view.alpha = 0.5
        return view
    }()
    
    let messageView: UIView = {
        let view = UIView()
        view.backgroundColor = .customWhite
        view.layer.cornerRadius = 16
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .Body1_M16
        label.textColor = .customBlack
        label.textAlignment = .center
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .Title4_R14
        label.textColor = .customBlack
        label.textAlignment = .center
        return label
    }()
    
    let buttonStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()
    
    let cancelButton: MainButton = MainButton(title: "취소", type: .cancel)
    let okButton: MainButton = MainButton(title: "확인", type: .fill)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.addSubview(bgView)
        bgView.addSubview(messageView)
        
        [titleLabel, subTitleLabel, buttonStackView].forEach { subView in
            messageView.addSubview(subView)
        }
        
        [cancelButton, okButton].forEach { subView in
            buttonStackView.addArrangedSubview(subView)
        }
    }
    
    func setupConstraints() {
        bgView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        messageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalToSuperview().multipliedBy(0.2)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview().inset(10)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(titleLabel)
            $0.top.equalTo(titleLabel.snp.bottom)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.leading.trailing.equalTo(subTitleLabel)
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    func showAlert(title: String, subTitle: String) {
        self.titleLabel.text = title
        self.subTitleLabel.text = subTitle
        
        UIApplication.shared.keyWindow?.addSubview(bgView)
    }
    
//    func showAlert(title: String, message: String, alertType: AlertType) {
//           self.titleLbl.text = title
//           self.messageLbl.text = message
//
//           switch alertType {
//           case .success:
//               img.image = UIImage(named: "Success")
//               doneBtn.backgroundColor =  colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
//           case .failure:
//               img.image = UIImage(named: "Failure")
//               doneBtn.backgroundColor =  colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
//           }
//
//           UIApplication.shared.keyWindow?.addSubview(parentView)
//    }
}
