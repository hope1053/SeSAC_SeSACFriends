//
//  OnBoardingViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/24.
//

import UIKit

import RxCocoa
import RxSwift

class OnBoardingViewController: BaseViewController {
    
    let viewModel = OnBoardingViewModel()
    let disposeBag = DisposeBag()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    let pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = 3
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
    
    override func configureView() {
        super.configureView()
        [collectionView, pageControl, nextButton].forEach { subView in
            view.addSubview(subView)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(OnBoardingCollectionViewCell.self, forCellWithReuseIdentifier: OnBoardingCollectionViewCell.identifier)
    }
    
    override func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalToSuperview().multipliedBy(0.75)
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
            $0.top.equalTo(collectionView.snp.bottom)
            $0.bottom.equalTo(nextButton.snp.top)
        }
    }
}

extension OnBoardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.onboardingGuide.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCollectionViewCell.identifier, for: indexPath) as? OnBoardingCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.guideLabel.text = viewModel.onboardingGuide[indexPath.row]
        cell.imageView.image = UIImage(named: viewModel.onboardingImages[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.8)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / scrollView.frame.width)
        self.pageControl.currentPage = page
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
