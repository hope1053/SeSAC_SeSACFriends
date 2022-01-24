//
//  BaseViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/19.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupConstraints()
    }
    
    func configureView() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.customBlack
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "arrow")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrow")
        self.navigationController?.navigationBar.topItem?.title = ""
    }
    
    func setupConstraints() {
        
    }
    
}
