//
//  AddHobbyViewController.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/02/15.
//

import UIKit

class AddHobbyViewController: BaseViewController {
    
    let hobbyView = HobbyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setupSearchBar() {
        let searchBar = UISearchBar()
        searchBar.placeholder = "띄어쓰기로 복수 입력이 가능해요"
        searchBar.enablesReturnKeyAutomatically = false
        self.navigationItem.titleView = searchBar
        
        searchBar.delegate = self
    }
}

extension AddHobbyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HobbyCollectionViewCell.identifier, for: indexPath) as? HobbyCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let array = ["안녕","안녕하세요","안녕하세요 저는 포마입니다.","안녕하세요 만나서 정말 반갑습니다."]
        cell.button.setTitle(array[indexPath.item], for: .normal)
        
        if indexPath.section == 0 {
            cell.button.serverRecommended()
        } else {
            cell.button.outline()
            let buttonImage = UIImage(named: "close_small")?.withRenderingMode(.alwaysTemplate)
            cell.button.setImage(buttonImage, for: .normal)
            cell.button.tintColor = UIColor.brandGreen
            cell.button.semanticContentAttribute = .forceRightToLeft
        }
        
        return cell
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
}

extension AddHobbyViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 입력한 데이터 추가하고 collection view reload하는 로직
        searchBar.resignFirstResponder()
    }
}


