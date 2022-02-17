//
//  HomeAnnotationView.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/17.
//

import MapKit

final class HomeAnnotationView: MKAnnotationView {
       
    static let identifier = "HomeAnnotationView"
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        configureView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        self.backgroundColor = .clear
    }

    func setupConstraints() {
        self.snp.makeConstraints {
            $0.width.height.equalTo(80)
        }
    }
}

final class HomeCustomAnnotation: NSObject, MKAnnotation {
    var sesacImageName: String
    var coordinate: CLLocationCoordinate2D
    
    init(image: String, coordinate: CLLocationCoordinate2D) {
        self.sesacImageName = image
        self.coordinate = coordinate
        super.init()
    }
}
