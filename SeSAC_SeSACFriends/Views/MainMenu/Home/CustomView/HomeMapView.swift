//
//  HomeMapView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/06.
//

import UIKit
import MapKit

class HomeMapView: UIView, BaseView {
    
    let mapView = MKMapView()
    
    let statusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "status_default"), for: .normal)
        return button
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
        [mapView, statusButton].forEach { subView in
            self.addSubview(subView)
        }
    }
    
    func setupConstraints() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        statusButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.2)
            $0.height.equalTo(statusButton.snp.width)
            $0.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
}
