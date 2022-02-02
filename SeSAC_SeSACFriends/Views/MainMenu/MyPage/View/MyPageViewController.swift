//
//  MyPageViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/26.
//

import UIKit

import RxCocoa
import RxSwift

class MyPageViewController: BaseViewController {
    
    let mainView = MyPageView()
    
    let disposeBag = DisposeBag()
    
    let viewModel = MyPageViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind() {
        viewModel.titleObservable
            .bind(to: mainView.tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(element) @ row \(row)"
                return cell
            }
            .disposed(by: disposeBag)
    }
    
    override func configureView() {
        super.configureView()
        
        mainView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}
