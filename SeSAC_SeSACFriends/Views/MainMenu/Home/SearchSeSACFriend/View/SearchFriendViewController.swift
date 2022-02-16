//
//  SearchFriendViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/15.
//

import UIKit

import Tabman
import Pageboy

class SearchFriendViewController: TabmanViewController {
    
    private var viewControllers = [NearFriendViewController(), RequestedFriendViewController()]
    private let buttonTitles = ["주변 새싹", "받은 요청"]
    
    let viewModel = QueueViewModel()
    
    let changeHobbyView = ChangeHobbyView()
    
    var completion: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        configureView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "새싹 찾기"
        
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let completion = completion {
            completion()
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        
        setupBar()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "찾기중단", style: .plain, target: self, action: #selector(stopSearchingTapped))
        
        view.addSubview(changeHobbyView)
        changeHobbyView.backgroundColor = .brandGreen
    }
    
    func setupConstraints() {
        changeHobbyView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
    }
    
    @objc func stopSearchingTapped() {
        viewModel.deque { message, status in
            if status == nil {
                self.view.makeToast(message, duration: 1.0, position: .bottom)
            } else if status == .success {
                if let vc = self.navigationController?.viewControllers.last(where: { $0.isKind(of: HomeViewController.self) }) {
                    vc.view.makeToast(message, duration: 1.0, position: .bottom)
                    self.navigationController?.popToViewController(vc, animated: true)
                }
            } else if status == .alreadyMatched {
                self.view.makeToast(message, duration: 1.0, position: .bottom)
                // 채팅화면으로 이동
            }
        }
    }
}

extension SearchFriendViewController {
    
    func setupBar() {
        let bar = TMBar.ButtonBar()
        
        bar.layout.transitionStyle = .snap
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        
        bar.indicator.overscrollBehavior = .none
        bar.indicator.weight = .light
        bar.indicator.tintColor = .brandGreen
        
        bar.buttons.customize { (button) in
            button.tintColor = .gray6
            button.selectedTintColor = .brandGreen
            button.font = .Title4_R14!
        }
        
        let systemBar = bar.systemBar()
        systemBar.backgroundStyle = .clear
        
        addBar(bar, dataSource: self, at: .top)
    }
}

extension SearchFriendViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return viewControllers.count
    }
    
    func viewController(for pageboyViewController: PageboyViewController, at index: PageboyViewController.PageIndex) -> UIViewController? {
        return viewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let title = buttonTitles[index]
        return TMBarItem(title: title)
    }
    
}
