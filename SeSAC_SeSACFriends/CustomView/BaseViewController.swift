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
    }
    
    func setupConstraints() {
        
    }
    
}
