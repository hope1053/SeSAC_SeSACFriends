//
//  OnBoardingViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/22.
//

import UIKit
import RxSwift
import RxCocoa

class OnBoardingViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    var currentPage = 0
    
    let onboardingImages: [UIImage] = [UIImage(named: "onboarding_img1")!, UIImage(named: "onboarding_img2")!, UIImage(named: "onboarding_img3")!]
    let onboardingGuide: [String] = [
        """
        위치 기반으로 빠르게
        주위 친구를 확인
        """,
        """
        관심사가 같은 친구를
        찾을 수 있어요
        """,
        "SeSAC Friends"
    ]
    
    let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
    let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
    
    let guideLabel: UILabel = {
        let label = UILabel()
        label.text = """
        위치 기반으로 빠르게
        주위 친구를 확인
        """
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.Title1_M16
        return label
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "onboarding_img1")
        return image
    }()
    
    let pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = 3
        control.addTarget(self, action: #selector(pageChanged), for: .valueChanged)
        control.currentPageIndicatorTintColor = UIColor.customBlack
        control.pageIndicatorTintColor = UIColor.gray5
        return control
    }()
    
    let nextButton = MainButton(title: "시작하기", type: .fill)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkFirstLaunch()
        bind()
    }
    
    func bind() {
        nextButton
            .rx.tap
            .subscribe { _ in
                let phoneAuthVC = PhoneNumInputViewController()
                let sd = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
                sd?.window?.rootViewController = phoneAuthVC
            }
            .disposed(by: disposeBag)
    }
    
    func checkFirstLaunch() {
        UserDefaults.standard.set("no", forKey: "isFirstLaunch")
    }
    
    @objc func handleSwipes(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            if sender == leftSwipe {
                if currentPage < 2 {
                    currentPage += 1
                }
            } else {
                if currentPage > 0 {
                    currentPage -= 1
                }
            }
            
            guideLabel.text = onboardingGuide[currentPage]
            imageView.image = onboardingImages[currentPage]
        }
    }
    
    @objc func pageChanged(_ sender: UIPageControl) {
        guideLabel.text = onboardingGuide[sender.currentPage]
        imageView.image = onboardingImages[sender.currentPage]
    }
    
    override func configureView() {
        super.configureView()
        [guideLabel, imageView, pageControl, nextButton].forEach { subView in
            view.addSubview(subView)
        }
        
        leftSwipe.direction = .left
        rightSwipe.direction = .right

        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
    }
    
    override func setupConstraints() {
        
        guideLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(0.5)
        }
        
        imageView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(0.96)
            $0.height.equalTo(imageView.snp.width)
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().multipliedBy(1.05)
        }
        
        nextButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(48)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
        
        pageControl.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom)
            $0.bottom.equalTo(nextButton.snp.top)
        }
    }
}
