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

final class HomeViewController: BaseViewController {
    
    let viewModel = QueueViewModel()
    
    var locationManager: CLLocationManager?
    
    var isFirstUpdate: Bool = true
    
    var currentGender: Gender = .unknown
    
    let mapView = HomeMapView()
    
    let floatingButton = FloatingGenderButton()
    
    let disposeBag = DisposeBag()
    
    let noLocationServiceView = CustomAlertView()
    let noGenderView = CustomAlertView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        
        locationManager = CLLocationManager()
        locationManager!.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkStatus()
        isFirstUpdate = true
    }
    
    override func configureView() {
        super.configureView()
        self.navigationController?.isNavigationBarHidden = true
        
        [mapView, floatingButton].forEach { subView in
            view.addSubview(subView)
        }
        
        mapView.mapView.delegate = self
        
        [floatingButton.totalButton, floatingButton.manButton, floatingButton.womanButton].forEach { button in
            button.addTarget(self, action: #selector(filterAnnotation), for: .touchUpInside)
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
    
    func bind() {
        floatingButton.updateLocationButton
            .rx.tap
            .bind { _ in
                if CLLocationManager.locationServicesEnabled() {
                    self.backToCurrentLocation()
                } else {
                    self.showFakeRegion()
                    self.noLocationServiceView.showAlert(title: "위치 서비스를 사용할 수 없습니다", subTitle: "설정에서 위치 서비스를 활성화시켜주세요")
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.friendData
            .bind { friendData in
                self.addAnnotation(self.viewModel.filterFriendData(gender: self.currentGender))
            }
            .disposed(by: disposeBag)
        
        viewModel.user.region
            .subscribe { _ in
                self.callFriendData()
            }
            .disposed(by: disposeBag)
        
        noLocationServiceView.okButton
            .rx.tap
            .bind { _ in
                guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
            .disposed(by: disposeBag)
        
        noGenderView.okButton
            .rx.tap
            .bind { _ in
                let navVC = self.tabBarController?.viewControllers![3] as! UINavigationController
                let myPageViewController: MyPageViewController = navVC.topVC as! MyPageViewController

                myPageViewController.setGenderCompletion = {
                    let manageView = ManageInfoViewController()
                    myPageViewController.navigationController?.pushViewController(manageView, animated: true)
                }

                self.tabBarController?.selectedIndex = 3
            }
            .disposed(by: disposeBag)
        
        mapView.statusButton
            .rx.tap
            .bind { _ in
                print(self.viewModel.user.gender.value)
                if self.viewModel.user.gender.value == .unknown {
                    self.noGenderView.showAlert(title: "새싹 찾기 기능을 이용하기 위해서는 성별이 필요해요!", subTitle: "성별을 설정해주세요")
                }
            }
            .disposed(by: disposeBag)
    }
    
    func callFriendData() {
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
    
    func showFakeRegion() {
        viewModel.currentCoordinate = CLLocationCoordinate2D(latitude: 37.517819364682694, longitude: 126.88647317074734)
        backToCurrentLocation()
    }
    
    func checkStatus() {
        viewModel.checkMyStatus { state, status in
            let currentStatus = UserInfo.shared.currentQueueState
            print(currentStatus)
            self.mapView.statusButton.setImage(UIImage(named: currentStatus.rawValue), for: .normal)
        }
    }
}

// MARK: 사용자 위치 권한 관련 메서드
extension HomeViewController: CLLocationManagerDelegate {
    
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
            // iOS 위치 서비스를 활성화해달라는 alert 띄우기
            showFakeRegion()
            self.noLocationServiceView.showAlert(title: "위치 서비스를 사용할 수 없습니다", subTitle: "설정에서 위치 서비스를 활성화시켜주세요")
        }
    }
    
    
    // 사용자 권한 확인 및 각 케이스별로 처리해주는 method
    func checkCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        // 사용자가 아직 위치 권한 허용 여부를 선택하지 않은 경우
        case .notDetermined:
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.requestWhenInUseAuthorization()
            locationManager!.startUpdatingLocation()
        // 위치권한이 없는 경우
        case .restricted, .denied:
            // alert 창을 통해 설정으로 이동하는 코드
            showFakeRegion()
            self.noLocationServiceView.showAlert(title: "위치 서비스를 사용할 수 없습니다", subTitle: "설정에서 위치 서비스를 활성화시켜주세요")
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager!.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
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
            viewModel.currentCoordinate = coordinate
            locationManager!.stopUpdatingLocation()
            if isFirstUpdate {
                viewModel.user.lat.accept(coordinate.latitude)
                viewModel.user.long.accept(coordinate.longitude)
                
                backToCurrentLocation()
                isFirstUpdate = false
            }
        } else {
            // 위치를 파악할 수 없어서? 여기서 처리를 해줘야되나?
            self.noLocationServiceView.showAlert(title: "위치 서비스를 사용할 수 없습니다", subTitle: "설정에서 위치 서비스를 활성화시켜주세요")
        }
        
    }
    
    // 위치 접근이 실패했을 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    // 현재 위치로 돌아가는 메서드
    func backToCurrentLocation() {
        let coordinate = viewModel.currentCoordinate
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 700, longitudinalMeters: 700)
        mapView.mapView.setRegion(region, animated: true)
        
        viewModel.user.lat.accept(coordinate.latitude)
        viewModel.user.long.accept(coordinate.longitude)
    }
}

// MARK: Annotation 및 MapViewDelegate 관련 메서드
extension HomeViewController: MKMapViewDelegate {
    
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
    
    // 지도 인터랙션 생길 때 마다 중심 위치 viewModel에 업데이트
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let centerCoordinate = mapView.centerCoordinate
        
        viewModel.user.lat.accept(centerCoordinate.latitude)
        viewModel.user.long.accept(centerCoordinate.longitude)
        
        viewModel.updateRegion(lat: centerCoordinate.latitude, long: centerCoordinate.longitude)
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
    
    // 성별 필터링 버튼 탭 될 때 마다 성별 변경 및 annotation 새로 추가
    @objc func filterAnnotation(_ sender: UIButton) {
        if sender.currentTitle == "전체" {
            currentGender = .unknown
        } else if sender.currentTitle == "남자" {
            currentGender = .man
        } else {
            currentGender = .woman
        }
        
        addAnnotation(viewModel.filterFriendData(gender: self.currentGender))
    }
}
