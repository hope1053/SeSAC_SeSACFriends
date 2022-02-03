//
//  MyPageViewModel.swift
//  SeSAC_SeSACFriends
//
//  Created by 최혜린 on 2022/01/28.
//

import UIKit
import RxRelay

struct tableViewData {
    let title: BehaviorRelay<[String]>
    let image: [UIImage]
}

class MyPageViewModel {
    
    let titles: [String] = [UserInfo.shared.userName, "공지사항", "자주 묻는 질문", "1:1 문의", "알림 설정", "이용 약관"]
    let images: [UIImage] = [UIImage(named: "profile_img")!, UIImage(named: "notice")!, UIImage(named: "faq")!, UIImage(named: "qna")!, UIImage(named: "setting_alarm")!, UIImage(named: "permit")!]
    
    var data: tableViewData {
        get {
            tableViewData(title: BehaviorRelay<[String]>(value: titles), image: images)
        }
    }
}
