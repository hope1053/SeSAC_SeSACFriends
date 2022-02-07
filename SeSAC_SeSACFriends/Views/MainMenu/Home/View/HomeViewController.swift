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
    
    let viewModel = QueueViewModel()
    
//    let locationManager = CLLocationManager()
    var locationManager: CLLocationManager?
    
    let mapView = HomeMapView()
    
    let floatingButton = FloatingGenderButton()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager!.delegate = self
    }
    
    override func configureView() {
        super.configureView()
        self.navigationController?.isNavigationBarHidden = true
        
        [mapView, floatingButton].forEach { subView in
            view.addSubview(subView)
        }
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
    
//    func test() {
//        viewModel.user.region.accept(1275130688)
//        viewModel.user.lat.accept(37.517819364682694)
//        viewModel.user.long.accept(126.88647317074734)
//
//        QueueAPI.onQueue { data, status in
//            switch status {
//            case .success:
//                print(data)
//            case .firebaseTokenError:
//                print("firebaseTokenError")
//            case .notMember:
//                self.view.makeToast("회원이 아님", duration: 1.0, position: .bottom)
//            case .serverError:
//                self.view.makeToast("에러가 발생했습니다. 잠시 후 다시 시도해주세요", duration: 1.0, position: .bottom)
//            case .clientError:
//                print("잘못보내셨음..확인하세용^^")
//            }
//        }
//    }
}

extension HomeViewController {
    
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
        case .notDetermined:
            print("request...?")
            // 사용자가 아직 위치 권한 허용 여부를 선택하지 않은 경우
            // 앱이 받고 싶어하는 위치 데이터의 정확도 설정
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            // 위치 권한 요청
            locationManager!.requestWhenInUseAuthorization()
            // 위치 접근 시작하는 method, 초기 위치 수정 사항에 대해 가져오고 didUpdateLocations 메서드를 통해 delegate에게 알려줌
            locationManager!.startUpdatingLocation()
        case .restricted, .denied:
            print("denied...?")
            // restricted: 앱이 위치 서비스를 사용할 권한이 없는 경우 (ex. 보호자 통제 모드 -> 사용자가 앱 허용 권한을 변경할 수 없는 상태)
            // denied: 사용자가 권한 요청창에서 거절을 선택, 설정에서 비활성화, 위치 서비스 자체를 사용 중지, 비행기 모드 등
            // alert 창을 통해 설정으로 이동하는 코드
            break
        case .authorizedAlways:
            // 언제든지 위치 서비스를 사용할 수 있도록 승인한 상태(백그라운드 포함)
            print(authorizationStatus)
        case .authorizedWhenInUse:
            // 앱을 사용하는 동안만 위치 서비스를 사용할 수 있도록 승인한 상태 => didUpdateLocations 실행
            locationManager!.startUpdatingLocation()
            print("whenInuser...?")
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
        
        if let coordinate = locations.last?.coordinate {
            let annotation = MKPointAnnotation()
            annotation.title = "현재 위치"
            annotation.coordinate = coordinate
            mapView.mapView.addAnnotation(annotation)
            
            // 지도의 중심 바꾸기
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion(center: coordinate, span: span)
            mapView.mapView.setRegion(region, animated: true)
            
            // 업데이트가 너무 많이 되는 경우, 비효율적 -> 업데이트 멈춰달라고 요청 (비슷한 반경에서)
            locationManager!.stopUpdatingLocation()
        } else {
            // 위치 찾을 수 없는 경우
        }
        
    }
    
    // 위치 접근이 실패했을 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }

}
