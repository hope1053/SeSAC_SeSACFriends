//
//  HomeMapView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/06.
//

import UIKit
import MapKit

class HomeMapView: UIView, BaseView {
    
    let mapView: MKMapView = {
        let view = MKMapView()
        // 확대축소 배율 설정
        view.setCameraZoomRange(MKMapView.CameraZoomRange(minCenterCoordinateDistance: 100, maxCenterCoordinateDistance: 6000), animated: true)
        // 지도 회전 안되게 설정
        view.isRotateEnabled = false
        return view
    }()
    
    let markerView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "map_marker")
        return view
    }()
    
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
        [mapView, markerView, statusButton].forEach { subView in
            self.addSubview(subView)
        }
    }
    
    func setupConstraints() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        markerView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.13)
            $0.height.equalTo(markerView.snp.width)
            $0.center.equalToSuperview()
        }
        
        statusButton.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.2)
            $0.height.equalTo(statusButton.snp.width)
            $0.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
}
