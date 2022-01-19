//
//  MainViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/18.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var button = MainButton(title: "안농", type: .inactive)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalToSuperview().multipliedBy(0.05)
        }
        
        button.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
    }
    
    @objc func buttonSelected() {
        print("dd")
        button = MainButton(title: "yes", type: .fill)
    }
    
    
}
