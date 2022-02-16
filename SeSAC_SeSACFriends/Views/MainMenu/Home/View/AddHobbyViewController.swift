//
//  AddHobbyViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/15.
//

import UIKit

import RxSwift

class AddHobbyViewController: BaseViewController {
    
    let disposeBag = DisposeBag()
    
    let viewModel = QueueViewModel()
    
    let hobbyView = HobbyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        callFriendData()
    }
    
    override func configureView() {
        super.configureView()
                
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        
        view.addSubview(hobbyView)
        hobbyView.collectionView.delegate = self
        hobbyView.collectionView.dataSource = self
        
        setupSearchBar()
    }
    
    override func setupConstraints() {
        hobbyView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupSearchBar() {
        let searchBar = UISearchBar()
        searchBar.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        searchBar.enablesReturnKeyAutomatically = false
        self.navigationItem.titleView = searchBar
        
        searchBar.delegate = self
    }
    
    func bind() {
        viewModel.friendData
            .subscribe { _ in
                self.viewModel.hobbyListFromServer()
            }
            .disposed(by: disposeBag)
        
        viewModel.hobbyFromServer
            .bind { hobby in
                print(hobby)
                self.hobbyView.collectionView.reloadData()
            }
            .disposed(by: disposeBag)
        
        viewModel.myHobby
            .bind { _ in
                self.hobbyView.collectionView.reloadData()
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
}

extension AddHobbyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            let totalHobby = viewModel.totalHobby.value
            return totalHobby.count
        } else {
            return viewModel.myHobby.value.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HobbyCollectionViewCell.identifier, for: indexPath) as? HobbyCollectionViewCell else {
            return UICollectionViewCell()
        }

        if indexPath.section == 0 {
            let (server, _) : ([String], [String]) = viewModel.hobbyFromServer.value
            let totalHobby = viewModel.totalHobby.value
            
            cell.button.setTitle(totalHobby[indexPath.item], for: .normal)
            cell.button.setImage(nil, for: .normal)
            
            if indexPath.item < server.count {
                cell.button.serverRecommended()
            } else {
                cell.button.inactive()
            }
            
            return cell
        } else {
            
            let myHobby = viewModel.myHobby.value
            
            cell.button.setTitle(myHobby[indexPath.item], for: .normal)
            cell.button.outline()
            
            let buttonImage = UIImage(named: "close_small")?.withRenderingMode(.alwaysTemplate)
            cell.button.setImage(buttonImage, for: .normal)
            cell.button.tintColor = UIColor.brandGreen
            cell.button.semanticContentAttribute = .forceRightToLeft
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
          case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HobbyHeaderView.identifier, for: indexPath)

            guard let hobbyHeaderView = headerView as? HobbyHeaderView else {
                return headerView
            }
            
            if indexPath.section == 0 {
                hobbyHeaderView.label.text = "지금 주변에는"
            } else {
                hobbyHeaderView.label.text = "지금 내가 하고싶은"
            }
            
            return hobbyHeaderView
          default:
            assert(false, "Invalid element type")
          }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                         layout collectionViewLayout: UICollectionViewLayout,
                         referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 18) // you can change sizing here
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            viewModel.addMyHobbyFromTotalHobby(indexPath.item) {
                self.view.makeToast("중복된 취미입니다", duration: 1.0, position: .bottom)
            }
        } else {
            // 선택한 item index의 원소를 viewModel에서 삭제
            viewModel.deleteMyHobby(indexPath.item)
        }
    }
}

extension AddHobbyViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 입력한 데이터 viewModel에 추가하기
        guard let inputText = searchBar.text else { return }
        
        viewModel.addMyHobbyFromInputText(inputText) {
            self.view.makeToast("중복된 취미는 입력되지 않았습니다", duration: 1.0, position: .bottom)
        }
        
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}


