//
//  SeSACFriendView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/16.
//

import UIKit

import Tabman

final class SeSACFriendView: UIView, BaseView {
    
    let sesacImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "sprout")
        return image
    }()
    
    let noSeSACLabel: UILabel = {
        let label = UILabel()
        label.font = .Display1_R20
        label.textColor = .customBlack
        label.textAlignment = .center
        return label
    }()
    
    let noSeSACSubLabel: UILabel = {
        let label = UILabel()
        label.font = .Title4_R14
        label.textColor = .gray7
        label.textAlignment = .center
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        return tableView
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
        [sesacImageView, noSeSACLabel, noSeSACSubLabel, tableView].forEach { subView in
            self.addSubview(subView)
        }
    }
    
    func setupConstraints() {
        sesacImageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.22)
            $0.height.equalTo(sesacImageView.snp.width)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.63)
        }
        
        noSeSACLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(30)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(sesacImageView.snp.bottom).offset(40)
        }
        
        noSeSACSubLabel.snp.makeConstraints {
            $0.leading.trailing.equalTo(noSeSACLabel)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(noSeSACLabel.snp.bottom).offset(8)
        }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func updateUI(_ doesDataExist: Bool) {
        [sesacImageView, noSeSACLabel, noSeSACSubLabel].forEach { subView in
            subView.isHidden = doesDataExist
        }
         
         tableView.isHidden = !doesDataExist
    }
}
