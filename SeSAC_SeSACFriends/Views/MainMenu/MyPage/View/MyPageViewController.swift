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
        viewModel.data.title
            .bind(to: mainView.tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
                cell.textLabel?.text = "\(element)"
                cell.imageView?.image = self.viewModel.data.image[row]
                return cell
            }
            .disposed(by: disposeBag)
        
        mainView.tableView
            .rx.itemSelected
            .subscribe { [weak self] indexPath in
                self?.navigationController?.pushViewController(ManageInfoViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureView() {
        super.configureView()
        title = "내 정보"
        mainView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        mainView.tableView.rowHeight = 75
    }
}

//extension MyPageViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let height = UIScreen.main.bounds.height
//        if indexPath.row == 0 {
//            return height * 0.1
//        } else {
//            return height * 0.05
//        }
//    }
//}
