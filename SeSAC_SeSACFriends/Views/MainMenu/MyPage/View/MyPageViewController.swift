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
    
    var setGenderCompletion: (() -> Void)?
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "내 정보"
        
        if let setGenderCompletion = setGenderCompletion {
            setGenderCompletion()
        }
        setGenderCompletion = nil
    }
    
    func bind() {

        viewModel.data.title
            .bind(to: mainView.tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(element)"
                cell.imageView?.image = self.viewModel.data.image[row]
                cell.selectionStyle = .none
                return cell
            }
            .disposed(by: disposeBag)
        
        mainView.tableView
            .rx.itemSelected
            .filter { $0.row == 0 }
            .subscribe { [weak self] indexPath in
                self?.navigationController?.pushViewController(ManageInfoViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureView() {
        super.configureView()
        
        mainView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        mainView.tableView.rowHeight = 75
    }
}
