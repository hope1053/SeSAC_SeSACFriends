//
//  HomeViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/22.
//

import Foundation
import UIKit

import SnapKit
import RxCocoa
import RxSwift

class HomeViewController: BaseViewController {
    
    let mapView = HomeMapView()
    
    let floatingButton = FloatingGenderButton()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        self.navigationController?.isNavigationBarHidden = true
        view.addSubview(mapView)
        view.addSubview(floatingButton)
    }
    
    override func setupConstraints() {
        mapView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        floatingButton.snp.makeConstraints {
            $0.width.equalTo(48)
            $0.height.equalTo(212)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
    }
}
