//
//  TestViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/03.
//

import UIKit

class TestViewController: UIViewController {

    let manageView = ManageInfoView()
    
    override func loadView() {
        self.view = manageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        view.addSubview(cardView)
//
//        cardView.snp.makeConstraints {
//            $0.width.equalToSuperview().multipliedBy(0.8)
//            $0.center.equalToSuperview()
//        }
    }
    
//    func configureView() {
//        view.addSubview(manageView)
//
//        manageView.snp.makeConstraints {
//            $0.edges.equalTo(view.safeAreaLayoutGuide)
//        }
//    }
}
