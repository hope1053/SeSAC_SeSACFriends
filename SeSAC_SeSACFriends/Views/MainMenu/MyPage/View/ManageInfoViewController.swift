//
//  ManageInfoViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/03.
//

import UIKit

class ManageInfoViewController: BaseViewController {
    
    let manageInfoView = ManageInfoView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        
        view.addSubview(manageInfoView)
    }
    
    override func setupConstraints() {
        manageInfoView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
