//
//  HomeViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/22.
//

import UIKit
import MapKit
import CoreLocation
import CoreLocationUI

import SnapKit
import RxCocoa
import RxSwift

class HomeViewController: BaseViewController {
    
    let sesacCoordinate = CLLocationCoordinate2D(latitude: 37.51818789942772, longitude: 126.88541765534976)
    
    let viewModel = QueueViewModel()
    
    var locationManager: CLLocationManager?
    
    var isFirstUpdate: Bool = true
    
    let mapView = HomeMapView()
    
    let floatingButton = FloatingGenderButton()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
        callFriendData()
//        addCustomPin()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isFirstUpdate = true
    }
    
    override func configureView() {
        super.configureView()
        self.navigationController?.isNavigationBarHidden = true
        
        [mapView, floatingButton].forEach { subView in
            view.addSubview(subView)
        }
        
        mapView.mapView.delegate = self
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
    
    func bind() {
        floatingButton.updateLocationButton
            .rx.tap
            .bind { self.backToCurrentLocation() }
            .disposed(by: disposeBag)
        
        viewModel.user.long
            .subscribe { long in
                print(long)
                self.callFriendData()
            }
            .disposed(by: disposeBag)
        
        viewModel.friendData
            .bind { friendData in
                self.addAnnotation(self.viewModel.filterFriendData(data: friendData))
            }
            .disposed(by: disposeBag)
    }
    
    func callFriendData() {
        viewModel.updateRegion()
        viewModel.callFriendData { status in
            switch status {
            case .notMember:
                self.view.makeToast("회원이 아닙니다", duration: 1.0, position: .bottom)
            case .serverError:
                self.view.makeToast("에러가 발생했습니다. 잠시 후 다시 시도해주세요", duration: 1.0, position: .bottom)
            default:
                break
            }
        }
    }
}

extension HomeViewController {
    
    private func addCustomPin() {
        let pin = MKPointAnnotation()
        //포인트 어노테이션은 뭔가요?
        pin.coordinate = sesacCoordinate
        pin.title = "새싹 영등포캠퍼스"
        pin.subtitle = "전체 3층짜리 건물"
        mapView.mapView.addAnnotation(pin)
    }
    
    // 위치 서비스가 켜져있는지 확인
    func checkUserLocationServicesAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager!.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        // iOS 위치 서비스 확인
        // 사용자가 위치 서비스를 사용하고 있다면 위치 권한에 따른 메서드 실행시키기
        if CLLocationManager.locationServicesEnabled() {
            checkCurrentLocationAuthorization(authorizationStatus)
        } else {
            // iOS 위치 권한을 허락해달라는 alert 띄우기
            print("iOS 위치 서비스 켜주세요")
        }
    }
    
    
    // 사용자 권한 확인 및 각 케이스별로 처리해주는 method
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        // 사용자가 아직 위치 권한 허용 여부를 선택하지 않은 경우
        case .notDetermined:
            // 앱이 받고 싶어하는 위치 데이터의 정확도 설정
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            // 위치 권한 요청
            locationManager!.requestWhenInUseAuthorization()
            // 위치 접근 시작하는 method, 초기 위치 수정 사항에 대해 가져오고 didUpdateLocations 메서드를 통해 delegate에게 알려줌
            locationManager!.startUpdatingLocation()
        // 위치권한이 없는 경우
        case .restricted, .denied:
            // alert 창을 통해 설정으로 이동하는 코드
            break
        case .authorizedAlways:
            // 언제든지 위치 서비스를 사용할 수 있도록 승인한 상태(백그라운드 포함)
            print(authorizationStatus)
        case .authorizedWhenInUse:
            // 앱을 사용하는 동안만 위치 서비스를 사용할 수 있도록 승인한 상태 => didUpdateLocations 실행
            locationManager!.startUpdatingLocation()
        case .authorized:
            print(authorizationStatus)
        @unknown default:
            break
        }
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    
    // 사용자가 권한 상태를 변경할 때 마다 실행되는 메서드 두 개
    // 1. iOS14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkUserLocationServicesAuthorization()
    }
    
    // 2. iOS14 이상 (정확도 관련 내용 추가)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserLocationServicesAuthorization() // viewDidLoad에서 실행하지않음!
    }
    
    // 사용자가 위치 허용을 한 경우 현재 위치로 mapView 변경하기
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
//        if let coordinate = locations.last?.coordinate {
////            let annotation = MKPointAnnotation()
////            annotation.title = "현재 위치"
////            annotation.coordinate = coordinate
////            mapView.mapView.addAnnotation(annotation)
//
//            // 지도의 중심 바꾸기
//            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//            let region = MKCoordinateRegion(center: coordinate, span: span)
//            mapView.mapView.setRegion(region, animated: true)
//
//            // 업데이트가 너무 많이 되는 경우, 비효율적 -> 업데이트 멈춰달라고 요청 (비슷한 반경에서)
//            locationManager!.stopUpdatingLocation()
//        } else {
//            // 위치 찾을 수 없는 경우
//        }
        if let coordinate = locations.last?.coordinate {
            viewModel.currentCoordinate = coordinate
            locationManager!.stopUpdatingLocation()
            if isFirstUpdate {
                viewModel.user.lat.accept(coordinate.latitude)
                viewModel.user.long.accept(coordinate.longitude)
                
                backToCurrentLocation()
                isFirstUpdate = false
            }
        }
        
    }
    
    // 위치 접근이 실패했을 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    func backToCurrentLocation() {
        let coordinate = viewModel.currentCoordinate
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 700, longitudinalMeters: 700)
        mapView.mapView.setRegion(region, animated: true)
        
        viewModel.user.lat.accept(coordinate.latitude)
        viewModel.user.long.accept(coordinate.longitude)
    }
    
    func addAnnotation(_ dataArray: [FromQueueDB]) {
        print(dataArray)
        let annotations = mapView.mapView.annotations
        mapView.mapView.removeAnnotations(annotations)
        
        for data in dataArray {
            let coordinate = CLLocationCoordinate2D(latitude: data.lat, longitude: data.long)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            
            mapView.mapView.addAnnotation(annotation)
        }
    }
}

extension HomeViewController: MKMapViewDelegate {
    // 지도 인터랙션 생길 때 마다 중심 위치 viewModel에 업데이트
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let centerCoordinate = mapView.centerCoordinate
        
        viewModel.user.lat.accept(centerCoordinate.latitude)
        viewModel.user.long.accept(centerCoordinate.longitude)
    }
    
    // Custom annotation 생성
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }

        var annotationView = self.mapView.mapView.dequeueReusableAnnotationView(withIdentifier: "Custom")
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Custom")
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "sesac_face_5")
        
        return annotationView
    }
}
