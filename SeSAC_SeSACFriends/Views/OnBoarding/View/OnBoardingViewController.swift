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
    
    let mainView = OnBoardingView()
    
    let viewModel = OnBoardingViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkFirstLaunch()
        bind()
    }
    
    override func configureView() {
        super.configureView()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    func bind() {
        mainView.nextButton
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
        self.mainView.pageControl.currentPage = page
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
